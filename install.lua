#!/usr/bin/env lua5.4
--[[
  install.lua

  Puerto de install.sh a Lua. Requiere `lua5.4` (o `lua`, `luajit`) y las
  herramientas de siempre (`stty`, `tput`, `git`, `sudo`) ya presentes en
  cualquier sistema donde el instalador bash original corría.

  Ejecutar como: lua5.4 install.lua   (o ./install.lua si es ejecutable)
]]

-- Permite requerir "utilities.installation.X" sin importar desde qué
-- directorio se invoque el script (equivalente al SCRIPT_DIR de bash).
local function script_dir()
  local source = debug.getinfo(1, "S").source:sub(2)
  local dir = source:match("(.*/)") or "./"
  return dir
end

local SCRIPT_DIR = script_dir():gsub("/$", "")
package.path = SCRIPT_DIR .. "/?.lua;" .. SCRIPT_DIR .. "/?/init.lua;" .. package.path

local cli = require("utilities.installation.cli")
local util = require("utilities.installation.util")
local installer = require("utilities.installation.installer")
local greeter = require("utilities.installation.greeter")
local done = require("utilities.installation.done")

-- --- Config -----------------------------------------------------------

local HOME = os.getenv("HOME") or ""
local LOG_FILE = SCRIPT_DIR .. "/fails.log"
local DEFAULT_INSTALL_DIR = HOME .. "/.config/nvim"
local PREVIOUS_DIR = HOME .. "/.config/previous-mu-vim"
local FONT_SOURCE = SCRIPT_DIR .. "/utilities/installation/iosevka_nerd_font.ttf"

local XDG_DATA_HOME = os.getenv("XDG_DATA_HOME")
if XDG_DATA_HOME == nil or XDG_DATA_HOME == "" then
  XDG_DATA_HOME = HOME .. "/.local/share"
end
local MARKER = XDG_DATA_HOME .. "/nvim/mu-vim-installed"

local FAIL_COUNT = 0

-- os.execute cambia de firma entre Lua 5.1/LuaJIT (devuelve el status
-- crudo del proceso como número — SIEMPRE truthy, incluso 0) y Lua 5.2+
-- (devuelve boolean, "exit"|"signal", código). Sin esto, cualquier
-- `if not os.execute(cmd) then` corriendo bajo luajit nunca detecta un
-- fallo real, y el instalador reporta éxito aunque el comando haya
-- tronado (ej. `cp` de la fuente cuando el .ttf no existe).
local function exec_ok(cmd)
  local a = os.execute(cmd)
  if type(a) == "number" then
    return a == 0
  end
  return a == true
end

local function dir_exists(path)
  return exec_ok('[ -d "' .. path .. '" ]')
end

local function log_fail(msg)
  -- Defensa en profundidad: el guard de más abajo debería evitar que
  -- SCRIPT_DIR desaparezca a mitad de ejecución, pero si de todos modos
  -- no existe (movido, permisos, lo que sea), caemos a /tmp en vez de que
  -- todo el script muera por un log que no se pudo escribir.
  local target_log = dir_exists(SCRIPT_DIR) and LOG_FILE or "/tmp/mu-vim-fails.log"
  local f = io.open(target_log, "a")
  if f then
    f:write(string.format("[%s] %s\n", os.date("%Y-%m-%d %H:%M:%S"), msg))
    f:close()
  end
  FAIL_COUNT = FAIL_COUNT + 1
end

local function mark_as_run()
  local f = io.open(MARKER, "w")
  if f then
    f:write(tostring(os.time()))
    f:close()
  end
end

local function expand_path(path)
  local home = HOME
  if path:sub(1, 1) == "~" then
    return home .. path:sub(2)
  end
  return path
end

-- --- Main ---------------------------------------------------------------
-- (mismo orden que install.sh: preguntar dir → validar → greeter → guard
-- de directorio/replace_old → gestor de paquetes)

-- Sudo se necesita más adelante para instalar los paquetes del sistema.
-- Lo pedimos ACÁ, con la terminal todavía en modo normal (cooked), antes
-- de que cli.lua toque `stty` para cualquier prompt interactivo. Pedirlo
-- más tarde —a mitad de una checklist en raw mode, compitiendo por
-- /dev/tty con nuestros propios prompts— es lo que hacía que la terminal
-- quedara en un estado roto y reescribiera contenido viejo con cada
-- tecla. `sudo -v` solo valida/cachea las credenciales (no ejecuta nada
-- todavía); las llamadas a `sudo` de installDependencies más adelante
-- reusan ese cache sin volver a pedir contraseña.
io.write("Se necesitan permisos de administrador para instalar dependencias del sistema.\n")
if not exec_ok("sudo -v") then
  io.stderr:write("No se pudieron validar los permisos de sudo, abortando.\n")
  os.exit(1)
end

local INSTALL_DIR = DEFAULT_INSTALL_DIR

local use_custom_dir = cli.confirm("¿Quieres usar un directorio de configuración custom? (por defecto es ~/.config/nvim)", false)

if use_custom_dir then
  local custom_path = cli.text("Escribe la ruta de tu directorio custom")
  if custom_path == nil or custom_path == "" then
    io.write("No se dio ninguna ruta, usando la ruta por defecto: " .. DEFAULT_INSTALL_DIR .. "\n")
  else
    INSTALL_DIR = expand_path(custom_path)
  end
end

if INSTALL_DIR:sub(1, 1) ~= "/" then
  io.stderr:write("Resolved install path is not absolute: " .. INSTALL_DIR .. "\n")
  os.exit(1)
end

local greeted_ok = greeter.greeter()
if greeted_ok then
  os.execute("sleep 5")
else
  log_fail("Something went wrong while greeting")
end

-- SAFETY GUARD: si la ruta de instalación resuelta es el mismo directorio
-- desde el que corre este script (el caso normal cuando mu-vim se clona
-- directo en ~/.config/nvim), replace_old NO debe tocarla. Ese directorio
-- YA ES la nueva config — no es una "config previa" que mover o borrar.
-- Hacerlo antes borraba los propios archivos del instalador a mitad de
-- ejecución (por eso fails.log dejaba de poder escribirse después: el
-- directorio que lo contenía acababa de ser borrado con rm -rf).
local function realpath(path)
  local handle = io.popen('realpath -m -- "' .. path .. '" 2>/dev/null')
  if not handle then return path end
  local resolved = handle:read("*l")
  handle:close()
  return resolved or path
end

local RESOLVED_INSTALL_DIR = realpath(INSTALL_DIR)

if RESOLVED_INSTALL_DIR == SCRIPT_DIR then
  io.write("Install directory (" .. INSTALL_DIR .. ") is the directory mu-vim is running from — nothing to back up, skipping.\n")
else
  local ok = util.replace_old(INSTALL_DIR, PREVIOUS_DIR)
  if not ok then
    log_fail("Something went wrong replacing old nvim config")
  end
end

local manager, manager_err = util.get_package_manager()
if manager == nil then
  log_fail("Could not detect a package manager")
else
  io.write("Detected package manager: " .. manager .. "\n")

  -- Extras: checklist multi-selección, todo pre-marcado (como los
  -- "optionalDependencies" que la mayoría de instaladores tipo pnpm traen
  -- activados salvo que el usuario los desmarque).
  local extra_options = {}
  for _, pkg in ipairs(installer.EXTRA_PACKAGES) do
    table.insert(extra_options, { label = pkg.name, value = pkg.name, desc = pkg.desc, checked = true })
  end
  local chosen_extras = cli.multi_select("Paquetes extra a instalar (todos opcionales):", extra_options)

  local packages = {}
  for _, name in ipairs(installer.CORE_PACKAGES) do
    table.insert(packages, name)
  end
  for _, name in ipairs(chosen_extras) do
    table.insert(packages, name)
  end

  if installer.installDependencies(manager, packages) then
    done.installation_success()
  else
    log_fail("installDependencies failed for manager: " .. manager)
  end
end

mark_as_run()

if installer.install_font(FONT_SOURCE) then
  io.write("Fuente instalada correctamente.\n")
else
  log_fail("No se pudo instalar la fuente Iosevka Nerd Font")
end

if FAIL_COUNT > 0 then
  io.write("It seems there were some failures (" .. FAIL_COUNT .. "), please submit an issue at:\n\n")
  io.write("\thttps://github.com/AndresMpa/mu-vim/issues/new\n")
  io.write("Details logged in: " .. LOG_FILE .. "\n")
  os.exit(1)
end

os.exit(0)
