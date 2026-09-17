--[[
  utilities/installation/installer.lua

  Puerto de utilities/installation/installer.sh, con un cambio de
  comportamiento respecto al original: PACKAGES ahora está dividido en
  CORE_PACKAGES (siempre se instalan, imprescindibles para que mu-vim
  funcione) y EXTRA_PACKAGES (opcionales, el usuario elige cuáles quiere
  vía la checklist de cli.lua). install.lua es quien pregunta y arma la
  lista final antes de llamar a installDependencies().

  Nota sobre nombres de paquete: no son uniformes entre distros ("fd" es
  "fd-find" en Debian/Ubuntu, "python-neovim" es "python3-neovim" en
  Debian/Fedora). Igual que el script original, esto no remapea por
  distro — si un nombre no existe en tu distro, esa instalación fallará.
]]

local M = {}

M.CORE_PACKAGES = {
  "nodejs",
  "pnpm",
  "ripgrep",
  "fd",
  "python-neovim",
  "luarocks",
}

M.EXTRA_PACKAGES = {
  { name = "zenity", desc = "Diálogos GUI usados por algunos scripts" },
  { name = "shfmt", desc = "Formateador de scripts de shell" },
  { name = "stylua", desc = "Formateador de código Lua" },
}

-- Ver comentario en install.lua: os.execute bajo Lua 5.1/LuaJIT devuelve
-- un número crudo (siempre truthy), no boolean. Esto normaliza ambos
-- casos para que los `if not exec_ok(cmd)` de más abajo detecten fallos
-- de verdad, sin importar con qué intérprete se corra el script.
local function exec_ok(cmd)
  local a = os.execute(cmd)
  if type(a) == "number" then
    return a == 0
  end
  return a == true
end

local function has_command(cmd)
  return exec_ok("command -v " .. cmd .. " >/dev/null 2>&1")
end

function M.install_packer()
  local home = os.getenv("HOME") or ""
  local packer_dir = home .. "/.local/share/nvim/site/pack/packer/start/packer.nvim"

  if exec_ok('[ -d "' .. packer_dir .. '" ]') then
    io.write("packer.nvim already present, skipping clone\n")
    return true
  end

  local ok = exec_ok(
    'git clone --depth 1 https://github.com/wbthomason/packer.nvim "' .. packer_dir .. '"'
  )
  if not ok then
    io.stderr:write("Failed to clone packer.nvim\n")
    return false
  end
  return true
end

-- packages: array de nombres de paquete (ya combinada: core + extras
-- elegidos). manager: nombre del gestor detectado por util.get_package_manager.
function M.installDependencies(manager, packages)
  if manager == nil or manager == "" then
    io.stderr:write("installDependencies: expected a package manager name\n")
    return false
  end
  if packages == nil or #packages == 0 then
    io.stderr:write("installDependencies: expected a non-empty package list\n")
    return false
  end

  local status = true

  if manager == "pacman" and has_command("yay") then
    if not exec_ok("yay -S --noconfirm nvim-packer-git") then
      io.stderr:write("yay failed to install nvim-packer-git\n")
      status = false
    end
  else
    if manager == "pacman" then
      io.stderr:write("yay not found, falling back to a manual packer.nvim clone\n")
    end
    if not M.install_packer() then
      status = false
    end
  end

  local pkg_list = table.concat(packages, " ")

  local commands = {
    ["apt-get"] = "sudo apt-get update && sudo apt-get install -y " .. pkg_list,
    pacman = "sudo pacman -Sy --noconfirm " .. pkg_list,
    dnf = "sudo dnf install -y " .. pkg_list,
    zypp = "sudo zypper --non-interactive install " .. pkg_list,
    zypper = "sudo zypper --non-interactive install " .. pkg_list,
    emerge = "sudo emerge --ask " .. pkg_list,
    apk = "sudo apk add " .. pkg_list,
  }

  local command = commands[manager]
  if command == nil then
    io.write("It seems that I do not know how to handle package manager '" .. manager .. "'.\n")
    io.write("You need to install these packages manually: " .. pkg_list .. "\n")
    return false
  end

  if not exec_ok(command) then
    status = false
  end

  return status
end

-- --- install_font -------------------------------------------------------
--
-- Copia la Nerd Font empaquetada con mu-vim al directorio de fuentes del
-- usuario y refresca el cache (fc-cache en Linux; en mac Font Book la
-- recoge sola, no hace falta refrescar nada). font_path = ruta absoluta
-- al .ttf, ya resuelta por install.lua con SCRIPT_DIR.
function M.install_font(font_path)
  if not exec_ok('[ -f "' .. font_path .. '" ]') then
    io.stderr:write("[ERROR] Font source not found: " .. font_path .. "\n")
    return false
  end

  local home = os.getenv("HOME") or ""
  local handle = io.popen("uname -s 2>/dev/null")
  local os_name = handle and handle:read("*l") or ""
  if handle then handle:close() end

  local fonts_dir = (os_name == "Darwin") and (home .. "/Library/Fonts") or (home .. "/.local/share/fonts")

  if not exec_ok('mkdir -p -- "' .. fonts_dir .. '"') then
    io.stderr:write("The fonts directory could not load: " .. fonts_dir .. "\n")
    return false
  end

  if not exec_ok('cp -- "' .. font_path .. '" "' .. fonts_dir .. '/"') then
    io.stderr:write("[ERROR] The fonts was not added " .. fonts_dir .. "\n")
    return false
  end

  if os_name ~= "Darwin" and has_command("fc-cache") then
    exec_ok('fc-cache -f "' .. fonts_dir .. '" >/dev/null 2>&1')
  end

  return true
end

return M
