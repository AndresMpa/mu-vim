#!/usr/bin/env lua5.4
--[[
  install.lua

  Installer for Linux (pacman, apt, dnf), macOS (Homebrew), and Windows (winget).
  Needs lua (5.4 / lua / luajit) and git. sudo only on apt/dnf/pacman.

  Run: lua install.lua
]]

-- Allow require("utilities.installation.X") regardless of cwd.
local function script_dir()
  local source = debug.getinfo(1, "S").source:sub(2)
  local dir = source:match("(.*/)") or source:match("(.*\\)") or "./"
  return dir
end

local SCRIPT_DIR = script_dir():gsub("[/\\]$", "")
package.path = SCRIPT_DIR .. "/?.lua;" .. SCRIPT_DIR .. "/?/init.lua;" .. package.path

local cli = require("utilities.installation.cli")
local util = require("utilities.installation.util")
local installer = require("utilities.installation.installer")
local greeter = require("utilities.installation.greeter")
local done = require("utilities.installation.done")

SCRIPT_DIR = util.make_absolute(SCRIPT_DIR)

-- --- Config -----------------------------------------------------------

local HOME = util.home()
local LOG_FILE = SCRIPT_DIR .. "/fails.log"
local DEFAULT_INSTALL_DIR = util.nvim_config_dir()
local PREVIOUS_DIR = util.path_join(HOME, ".config", "previous-mu-vim")
if util.is_windows() then
  PREVIOUS_DIR = util.path_join(util.data_home(), "previous-mu-vim")
end
local FONT_SOURCE = SCRIPT_DIR .. "/utilities/installation/iosevka_nerd_font.ttf"
local MARKER = util.path_join(util.data_home(), "nvim", "mu-vim-installed")

local FAIL_COUNT = 0

-- Lua 5.1/LuaJIT returns a raw status number from os.execute (always
-- truthy, even 0). Lua 5.2+ returns a boolean. Normalize both.
local function exec_ok(cmd)
  local a = os.execute(cmd)
  if type(a) == "number" then
    return a == 0
  end
  return a == true
end

local function dir_exists(path)
  return util.dir_exists(path)
end

local function log_fail(msg)
  -- If SCRIPT_DIR is gone mid-run, log to the system temp directory.
  local fallback_log = (os.getenv("TEMP") and (os.getenv("TEMP") .. "/mu-vim-fails.log")) or "/tmp/mu-vim-fails.log"
  local target_log = dir_exists(SCRIPT_DIR) and LOG_FILE or fallback_log
  local f = io.open(target_log, "a")
  if f then
    f:write(string.format("[%s] %s\n", os.date("%Y-%m-%d %H:%M:%S"), msg))
    f:close()
  end
  FAIL_COUNT = FAIL_COUNT + 1
end

local function mark_as_run()
  util.mkdir_p(util.path_join(util.data_home(), "nvim"))
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

-- Ask for sudo while the terminal is still in cooked mode, before any
-- stty raw prompts. Later sudo calls reuse the cached credentials.
local manager, manager_err = util.get_package_manager()
if manager == nil then
  io.stderr:write((manager_err or "No package manager") .. "\n")
end

if manager and util.needs_sudo(manager) then
  io.write("Administrator privileges are required to install system packages.\n")
  if not exec_ok("sudo -v") then
    io.stderr:write("Could not validate sudo credentials. Aborting.\n")
    os.exit(1)
  end
end

local INSTALL_DIR = DEFAULT_INSTALL_DIR

local use_custom_dir = cli.confirm("Use a custom config directory? (default is " .. DEFAULT_INSTALL_DIR .. ")", false)

if use_custom_dir then
  local custom_path = cli.text("Enter the path of your custom directory")
  if custom_path == nil or custom_path == "" then
    io.write("No path given, using the default: " .. DEFAULT_INSTALL_DIR .. "\n")
  else
    INSTALL_DIR = expand_path(custom_path)
  end
end

if not util.is_absolute(INSTALL_DIR) then
  io.stderr:write("Resolved install path is not absolute: " .. INSTALL_DIR .. "\n")
  os.exit(1)
end

local greeted_ok = greeter.greeter()
if greeted_ok then
  os.execute("sleep 5")
else
  log_fail("Something went wrong while greeting")
end

-- Never move/delete the directory we are running from. A relative
-- SCRIPT_DIR (./) used to miss this and rm -rf the cwd; brew/pip/pnpm
-- then failed with getcwd ENOENT.
local RESOLVED_INSTALL_DIR = util.realpath(INSTALL_DIR)
local CWD = util.make_absolute(util.pwd())

if RESOLVED_INSTALL_DIR == SCRIPT_DIR
    or util.path_is_under(CWD, RESOLVED_INSTALL_DIR)
    or util.path_is_under(SCRIPT_DIR, RESOLVED_INSTALL_DIR) then
  io.write("Install directory (" .. INSTALL_DIR .. ") is the directory mu-vim is running from — nothing to back up, skipping.\n")
else
  local ok = util.replace_old(INSTALL_DIR, PREVIOUS_DIR)
  if not ok then
    log_fail("Something went wrong replacing old nvim config")
  end
end

if manager == nil then
  log_fail(manager_err or "Could not detect a package manager")
else
  io.write("Detected package manager: " .. manager .. "\n")

  local extra_options = {}
  for _, pkg in ipairs(installer.EXTRA_PACKAGES) do
    table.insert(extra_options, { label = pkg.name, value = pkg.name, desc = pkg.desc, checked = true })
  end
  local chosen_extras = cli.multi_select("Optional extra packages:", extra_options)

  if installer.installDependencies(manager, chosen_extras) then
    done.installation_success()
  else
    log_fail("installDependencies failed for manager: " .. manager)
  end
end

mark_as_run()

if installer.install_font(FONT_SOURCE) then
  io.write("Font installed.\n")
else
  log_fail("Could not install the Iosevka Nerd Font")
end

if FAIL_COUNT > 0 then
  io.write("It seems there were some failures (" .. FAIL_COUNT .. "), please submit an issue at:\n\n")
  io.write("\thttps://github.com/AndresMpa/mu-vim/issues/new\n")
  io.write("Details logged in: " .. LOG_FILE .. "\n")
  os.exit(1)
end

os.exit(0)
