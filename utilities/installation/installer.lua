--[[
  utilities/installation/installer.lua

  Install Neovim deps for pacman, apt, dnf, Homebrew, and winget.
  Package names are remapped per manager. pnpm is a core requirement;
  if the distro has no pnpm package, we use the official installer.
]]

local util = require("utilities.installation.util")

local M = {}

-- Display names used in the extras checklist (manager-agnostic).
M.EXTRA_PACKAGES = {
  { name = "zenity", desc = "GUI dialogs used by some scripts (Linux)" },
  { name = "shfmt", desc = "Shell script formatter" },
  { name = "stylua", desc = "Lua formatter" },
  { name = "black", desc = "Python formatter" },
}

local CORE_BY_MANAGER = {
  pacman = { "neovim", "nodejs", "pnpm", "ripgrep", "fd", "python-neovim", "luarocks" },
  ["apt-get"] = { "neovim", "nodejs", "ripgrep", "fd-find", "python3-neovim", "luarocks" },
  dnf = { "neovim", "nodejs", "ripgrep", "fd-find", "python3-neovim", "luarocks" },
  brew = { "neovim", "node", "pnpm", "ripgrep", "fd", "luarocks" },
}

local EXTRA_BY_MANAGER = {
  pacman = { zenity = "zenity", shfmt = "shfmt", stylua = "stylua", black = "python-black" },
  ["apt-get"] = { zenity = "zenity", shfmt = "shfmt", black = "black" },
  dnf = { zenity = "zenity", shfmt = "shfmt", black = "python3-black" },
  brew = { shfmt = "shfmt", stylua = "stylua", black = "black" },
}

-- winget uses package ids, not distro names.
local WINGET_CORE = {
  { id = "Neovim.Neovim", name = "neovim" },
  { id = "OpenJS.NodeJS.LTS", name = "nodejs" },
  { id = "pnpm.pnpm", name = "pnpm" },
  { id = "BurntSushi.ripgrep.MSVC", name = "ripgrep" },
  { id = "sharkdp.fd", name = "fd" },
}

local WINGET_EXTRA = {
  shfmt = "mvdan.Shfmt",
  stylua = "JohnnyMorganz.StyLua",
}

local function exec_ok(cmd)
  return util.exec_ok(cmd)
end

function M.core_packages(manager)
  return CORE_BY_MANAGER[manager] or {}
end

function M.resolve_extras(manager, chosen)
  local mapped = {}
  local table_for = EXTRA_BY_MANAGER[manager] or {}
  for _, name in ipairs(chosen) do
    if manager == "winget" then
      if WINGET_EXTRA[name] then
        mapped[#mapped + 1] = { kind = "winget", id = WINGET_EXTRA[name] }
      end
    elseif table_for[name] then
      mapped[#mapped + 1] = table_for[name]
    end
  end
  return mapped
end

function M.install_pckr()
  -- Same path plugins.lua uses: stdpath("data")/pckr/pckr.nvim
  local pckr_dir = util.path_join(util.data_home(), "nvim", "pckr", "pckr.nvim")

  if util.dir_exists(pckr_dir) then
    io.write("pckr.nvim already present, skipping clone\n")
    return true
  end

  util.mkdir_p(pckr_dir:match("(.+)[/\\][^/\\]+$") or pckr_dir)
  local ok = exec_ok(
    'git clone --filter=blob:none https://github.com/lewis6991/pckr.nvim "' .. pckr_dir .. '"'
  )
  if not ok then
    io.stderr:write("Failed to clone pckr.nvim\n")
    return false
  end
  return true
end

function M.pnpm_home()
  if util.is_windows() then
    return util.path_join(util.data_home(), "pnpm")
  end
  return util.path_join(util.home(), ".local", "share", "pnpm")
end

function M.pnpm_env()
  local home = M.pnpm_home()
  if util.is_windows() then
    return string.format('set PNPM_HOME=%s&& set PATH=%s;%%PATH%%&& ', home, home)
  end
  return string.format('PNPM_HOME="%s" PATH="%s:$PATH" ', home, home)
end

function M.ensure_pnpm()
  util.mkdir_p(M.pnpm_home())
  if util.has_command("pnpm") then
    return true
  end
  io.write("pnpm is not on PATH, using the official installer\n")
  if util.is_windows() then
    return exec_ok(
      'powershell -NoProfile -Command "iwr https://get.pnpm.io/install.ps1 -useb | iex"'
    )
  end
  return exec_ok("curl -fsSL https://get.pnpm.io/install.sh | sh -")
end

-- Global pnpm packages go under the user prefix. A system PNPM_HOME
-- under /usr/local is not writable and fails with "create global install dir".
function M.ensure_formatters()
  local status = true
  local env = M.pnpm_env()
  if not util.has_command("biome") then
    io.write("Installing biome with pnpm (user prefix)\n")
    if not exec_ok(env .. "pnpm add -g @biomejs/biome") then
      io.stderr:write("Could not install biome with pnpm\n")
      status = false
    end
  end
  if not util.has_command("black") then
    io.write("Installing black with pip\n")
    if not exec_ok("pip3 install --user black") and not exec_ok("pip install --user black") then
      io.stderr:write("Could not install black\n")
      status = false
    end
  end
  return status
end

local function install_unix_packages(manager, packages)
  local pkg_list = table.concat(packages, " ")
  local commands = {
    ["apt-get"] = "sudo apt-get update && sudo apt-get install -y " .. pkg_list,
    pacman = "sudo pacman -Sy --noconfirm " .. pkg_list,
    dnf = "sudo dnf install -y " .. pkg_list,
    brew = "brew install " .. pkg_list,
  }
  local command = commands[manager]
  if command == nil then
    return false
  end
  return exec_ok(command)
end

local function install_winget(id)
  return exec_ok(
    'winget install -e --id ' .. id .. " --accept-package-agreements --accept-source-agreements"
  )
end

function M.installDependencies(manager, extra_names)
  extra_names = extra_names or {}
  if manager == nil or manager == "" then
    io.stderr:write("installDependencies: expected a package manager name\n")
    return false
  end

  local status = true

  if not M.install_pckr() then
    status = false
  end

  if manager == "winget" then
    for _, pkg in ipairs(WINGET_CORE) do
      io.write("winget install " .. pkg.id .. "\n")
      if not install_winget(pkg.id) then
        io.stderr:write("winget failed for " .. pkg.id .. "\n")
        status = false
      end
    end
    for _, extra in ipairs(M.resolve_extras("winget", extra_names)) do
      io.write("winget install " .. extra.id .. "\n")
      if not install_winget(extra.id) then
        status = false
      end
    end
    if not exec_ok("pip install --user pynvim") and not exec_ok("pip3 install --user pynvim") then
      io.write("Could not pip-install pynvim; :checkhealth will say so.\n")
    end
  else
    local packages = {}
    for _, name in ipairs(M.core_packages(manager)) do
      packages[#packages + 1] = name
    end
    for _, name in ipairs(M.resolve_extras(manager, extra_names)) do
      packages[#packages + 1] = name
    end
    if #packages == 0 then
      io.stderr:write("installDependencies: no packages mapped for " .. manager .. "\n")
      return false
    end
    io.write("Installing with " .. manager .. ": " .. table.concat(packages, " ") .. "\n")
    if not install_unix_packages(manager, packages) then
      status = false
    end
    if manager == "brew" then
      exec_ok("pip3 install --user pynvim")
    end
  end

  if not M.ensure_pnpm() then
    io.stderr:write("Could not install pnpm\n")
    status = false
  end

  if not M.ensure_formatters() then
    status = false
  end

  return status
end

function M.install_font(font_path)
  if not util.file_exists(font_path) then
    io.stderr:write("[ERROR] Font source not found: " .. font_path .. "\n")
    return false
  end

  local fonts_dir
  if util.is_windows() then
    fonts_dir = util.path_join(util.data_home(), "Microsoft", "Windows", "Fonts")
  elseif util.is_darwin() then
    fonts_dir = util.path_join(util.home(), "Library", "Fonts")
  else
    fonts_dir = util.path_join(util.home(), ".local", "share", "fonts")
  end

  if not util.mkdir_p(fonts_dir) then
    io.stderr:write("The fonts directory could not load: " .. fonts_dir .. "\n")
    return false
  end

  if not util.copy_file(font_path, fonts_dir) then
    io.stderr:write("[ERROR] The font was not added " .. fonts_dir .. "\n")
    return false
  end

  if not util.is_darwin() and not util.is_windows() and util.has_command("fc-cache") then
    exec_ok('fc-cache -f "' .. fonts_dir .. '" >/dev/null 2>&1')
  end

  return true
end

return M
