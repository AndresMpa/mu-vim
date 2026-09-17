--[[
  utilities/installation/util.lua

  OS detection, portable paths, and package-manager lookup.
  Linux: pacman, apt-get, dnf. macOS: Homebrew. Windows: winget.
]]

local cli = require("utilities.installation.cli")

local M = {}

function M.exec_ok(cmd)
  local a = os.execute(cmd)
  if type(a) == "number" then
    return a == 0
  end
  return a == true
end

function M.is_windows()
  if (os.getenv("OS") or ""):match("Windows") then
    return true
  end
  return package.config:sub(1, 1) == "\\"
end

function M.uname()
  if M.is_windows() then
    return "Windows"
  end
  local handle = io.popen("uname -s 2>/dev/null")
  if not handle then
    return "Linux"
  end
  local name = handle:read("*l") or ""
  handle:close()
  return name
end

function M.is_darwin()
  return M.uname() == "Darwin"
end

function M.home()
  local home = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
  return home
end

function M.data_home()
  if M.is_windows() then
    return os.getenv("LOCALAPPDATA") or (M.home() .. "\\AppData\\Local")
  end
  local xdg = os.getenv("XDG_DATA_HOME")
  if xdg and xdg ~= "" then
    return xdg
  end
  return M.home() .. "/.local/share"
end

function M.path_join(...)
  local sep = M.is_windows() and "\\" or "/"
  local parts = {}
  for i = 1, select("#", ...) do
    local part = select(i, ...)
    if part and part ~= "" then
      part = part:gsub("[/\\]+$", "")
      parts[#parts + 1] = part
    end
  end
  return table.concat(parts, sep)
end

function M.nvim_config_dir()
  if M.is_windows() then
    return M.path_join(M.data_home(), "nvim")
  end
  return M.path_join(M.home(), ".config", "nvim")
end

function M.file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

function M.dir_exists(path)
  if M.is_windows() then
    return M.exec_ok(string.format('if exist "%s\\" (exit 0) else (exit 1)', path))
  end
  return M.exec_ok(string.format('[ -d "%s" ]', path))
end

function M.path_exists(path)
  if M.is_windows() then
    return M.exec_ok(string.format('if exist "%s" (exit 0) else (exit 1)', path))
  end
  return M.exec_ok(string.format('[ -e "%s" ]', path))
end

function M.has_command(cmd)
  if M.is_windows() then
    return M.exec_ok(string.format('where %s >nul 2>nul', cmd))
  end
  return M.exec_ok("command -v " .. cmd .. " >/dev/null 2>&1")
end

function M.mkdir_p(path)
  if M.is_windows() then
    return M.exec_ok(string.format('mkdir "%s" 2>nul', path)) or M.dir_exists(path)
  end
  return M.exec_ok(string.format('mkdir -p -- "%s"', path))
end

function M.copy_file(src, dest_dir)
  if M.is_windows() then
    return M.exec_ok(string.format('copy /Y "%s" "%s"', src, dest_dir))
  end
  return M.exec_ok(string.format('cp -- "%s" "%s/"', src, dest_dir))
end

function M.mv(src, dest)
  if M.is_windows() then
    return M.exec_ok(string.format('move /Y "%s" "%s"', src, dest))
  end
  return M.exec_ok(string.format('mv -- "%s" "%s"', src, dest))
end

function M.rm_rf(path)
  if M.is_windows() then
    return M.exec_ok(string.format('rmdir /S /Q "%s"', path))
      or M.exec_ok(string.format('del /F /Q "%s"', path))
  end
  return M.exec_ok(string.format('rm -rf -- "%s"', path))
end

function M.is_absolute(path)
  if M.is_windows() then
    return path:match("^[%a]:") or path:match("^\\\\")
  end
  return path:sub(1, 1) == "/"
end

function M.realpath(path)
  if M.is_windows() then
    return path
  end
  local handle = io.popen('realpath -m -- "' .. path .. '" 2>/dev/null')
  if not handle then
    return path
  end
  local resolved = handle:read("*l")
  handle:close()
  return resolved or path
end

function M.get_package_manager()
  if M.is_windows() then
    if M.has_command("winget") then
      return "winget"
    end
    return nil, "Install winget (App Installer from Microsoft Store)"
  end
  if M.is_darwin() then
    if M.has_command("brew") then
      return "brew"
    end
    return nil, "Install Homebrew from https://brew.sh"
  end
  if M.has_command("pacman") then
    return "pacman"
  end
  if M.has_command("apt-get") then
    return "apt-get"
  end
  if M.has_command("dnf") then
    return "dnf"
  end
  local release_files = {
    { "/etc/arch-release", "pacman" },
    { "/etc/debian_version", "apt-get" },
    { "/etc/redhat-release", "dnf" },
    { "/etc/fedora-release", "dnf" },
  }
  for _, entry in ipairs(release_files) do
    if M.file_exists(entry[1]) then
      return entry[2]
    end
  end
  return nil, "No supported package manager detected (need pacman, apt, dnf, brew, or winget)"
end

function M.needs_sudo(manager)
  return manager == "pacman" or manager == "apt-get" or manager == "dnf"
end

function M.replace_old(target, backup_dir)
  if not M.path_exists(target) then
    return true
  end

  while true do
    local keep = cli.confirm(
      "Existe configuración previa en " .. target .. ". ¿Quieres conservarla como backup?",
      true
    )

    if keep then
      local parent = backup_dir:match("(.+)[/\\]") or "."
      if not M.mkdir_p(parent) then
        io.stderr:write("No se pudo crear el directorio padre de " .. backup_dir .. "\n")
        return false
      end
      if M.path_exists(backup_dir) then
        io.stderr:write("El destino del backup ya existe: " .. backup_dir .. "\n")
        return false
      end
      io.write("Respaldando configuración existente en " .. backup_dir .. "\n")
      return M.mv(target, backup_dir)
    else
      io.write("Eliminando configuración previa\n")
      return M.rm_rf(target)
    end
  end
end

return M
