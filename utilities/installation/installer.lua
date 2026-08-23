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
  "ripgrep",
  "fd",
  "python-neovim",
  "luarocks",
}

M.EXTRA_PACKAGES = {
  { name = "pnpm", desc = "Gestor de paquetes rápido, alternativa a npm" },
  { name = "zenity", desc = "Diálogos GUI usados por algunos scripts" },
  { name = "shfmt", desc = "Formateador de scripts de shell" },
  { name = "stylua", desc = "Formateador de código Lua" },
}

local function has_command(cmd)
  return os.execute("command -v " .. cmd .. " >/dev/null 2>&1") and true or false
end

function M.install_packer()
  local home = os.getenv("HOME") or ""
  local packer_dir = home .. "/.local/share/nvim/site/pack/packer/start/packer.nvim"

  if os.execute('[ -d "' .. packer_dir .. '" ]') then
    io.write("packer.nvim already present, skipping clone\n")
    return true
  end

  local ok = os.execute(
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
    if not os.execute("yay -S --noconfirm nvim-packer-git") then
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

  if not os.execute(command) then
    status = false
  end

  return status
end

return M
