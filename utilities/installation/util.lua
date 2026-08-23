--[[
  utilities/installation/util.lua

  Puerto de utilities/installation/util.sh.
]]

local cli = require("utilities.installation.cli")

local M = {}

local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

-- --- get_package_manager ---------------------------------------------------
--
-- Devuelve el nombre del gestor de paquetes detectado, o nil + mensaje de
-- error si no se reconoce ninguno. El orden importa (primer match gana)
-- porque algunas distros (p.ej. Manjaro) traen más de un release file.
local RELEASE_FILES = {
  { "/etc/debian_version", "apt-get" },
  { "/etc/redhat-release", "dnf" },
  { "/etc/arch-release", "pacman" },
  { "/etc/SuSE-release", "zypp" },
  { "/etc/gentoo-release", "emerge" },
  { "/etc/alpine-release", "apk" },
}

function M.get_package_manager()
  for _, entry in ipairs(RELEASE_FILES) do
    local release_file, manager = entry[1], entry[2]
    if file_exists(release_file) then
      return manager
    end
  end
  return nil, "No supported package manager detected"
end

-- --- replace_old ------------------------------------------------------------
--
-- Mueve la config existente a un backup, o la borra, según elija el
-- usuario. target = directorio de config actual; backup_dir = a dónde
-- moverla si el usuario quiere conservarla.
function M.replace_old(target, backup_dir)
  -- `[ -e ]` (a diferencia de io.open) funciona igual para archivos y
  -- directorios, que es lo que necesitamos aquí (target suele ser un dir).
  local exists = os.execute('[ -e "' .. target .. '" ]')
  if not exists then
    return true
  end

  while true do
    local keep = cli.confirm(
      "Existe configuración previa en " .. target .. ". ¿Quieres conservarla como backup?",
      true
    )

    if keep then
      local parent = backup_dir:match("(.*/)") or "./"
      local mkdir_ok = os.execute('mkdir -p -- "' .. parent .. '"')
      if not mkdir_ok then
        io.stderr:write("No se pudo crear el directorio padre de " .. backup_dir .. "\n")
        return false
      end
      if os.execute('[ -e "' .. backup_dir .. '" ]') then
        io.stderr:write("El destino del backup ya existe: " .. backup_dir .. "\n")
        return false
      end
      io.write("Respaldando configuración existente en " .. backup_dir .. "\n")
      return os.execute('mv -- "' .. target .. '" "' .. backup_dir .. '"') and true or false
    else
      io.write("Eliminando configuración previa\n")
      return os.execute('rm -rf -- "' .. target .. '"') and true or false
    end
  end
end

return M
