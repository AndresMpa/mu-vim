#!/usr/bin/env lua
--[[
  delete.lua

  Uninstall MμVim user data. Leaves the Neovim binary (and brew/apt/dnf
  packages such as node, pnpm, ripgrep) in place.

  Removes:
    - the nvim config directory
    - pckr plugins and the pckr.nvim clone
    - Mason packages and registries
    - nvim cache and state
    - the install marker and previous-config backup
    - the Iosevka Nerd Font file this installer copied

  Run from the config repo:  lua delete.lua
]]

local function script_dir()
  local source = debug.getinfo(1, "S").source:sub(2)
  local dir = source:match("(.*/)") or source:match("(.*\\)") or "./"
  return dir
end

local SCRIPT_DIR = script_dir():gsub("[/\\]$", "")
package.path = SCRIPT_DIR .. "/?.lua;" .. SCRIPT_DIR .. "/?/init.lua;" .. package.path

local cli = require("utilities.installation.cli")
local util = require("utilities.installation.util")

local function cache_home()
  if util.is_windows() then
    return os.getenv("TEMP") or util.data_home()
  end
  local xdg = os.getenv("XDG_CACHE_HOME")
  if xdg and xdg ~= "" then
    return xdg
  end
  return util.path_join(util.home(), ".cache")
end

local function state_home()
  if util.is_windows() then
    return util.data_home()
  end
  local xdg = os.getenv("XDG_STATE_HOME")
  if xdg and xdg ~= "" then
    return xdg
  end
  return util.path_join(util.home(), ".local", "state")
end

local function font_file()
  if util.is_windows() then
    return util.path_join(util.data_home(), "Microsoft", "Windows", "Fonts", "iosevka_nerd_font.ttf")
  end
  if util.is_darwin() then
    return util.path_join(util.home(), "Library", "Fonts", "iosevka_nerd_font.ttf")
  end
  return util.path_join(util.home(), ".local", "share", "fonts", "iosevka_nerd_font.ttf")
end

local function looks_like_muvim(dir)
  return util.file_exists(util.path_join(dir, "install.lua"))
    or util.file_exists(util.path_join(dir, "lua", "plugins.lua"))
end

local HOME = util.home()
local config_dir = util.nvim_config_dir()
local data_dir = util.path_join(util.data_home(), "nvim")
local cache_dir = util.path_join(cache_home(), "nvim")
local state_dir = util.path_join(state_home(), "nvim")
local previous_dir = util.path_join(HOME, ".config", "previous-mu-vim")
if util.is_windows() then
  previous_dir = util.path_join(util.data_home(), "previous-mu-vim")
end

local targets = {
  { path = data_dir, why = "Mason, pckr plugins, plugin data" },
  { path = cache_dir, why = "Neovim cache" },
  { path = state_dir, why = "Neovim state" },
  { path = previous_dir, why = "Backup of the previous config" },
  { path = font_file(), why = "Iosevka Nerd Font copied by install.lua" },
  { path = config_dir, why = "MμVim config (this repo if you cloned it here)" },
}

io.write("This removes MμVim config, Mason, and plugins.\n")
io.write("Neovim itself (the binary) is not uninstalled.\n\n")
for _, item in ipairs(targets) do
  local mark = util.path_exists(item.path) and "*" or " "
  io.write(string.format("  [%s] %s\n      %s\n", mark, item.path, item.why))
end
io.write("\n")

if not looks_like_muvim(config_dir) and not looks_like_muvim(SCRIPT_DIR) then
  io.stderr:write("No MμVim install found in " .. config_dir .. " or " .. SCRIPT_DIR .. "\n")
  os.exit(1)
end

if not cli.confirm("Delete the paths marked * ?", false) then
  io.write("Aborted.\n")
  os.exit(0)
end

local failed = 0
for _, item in ipairs(targets) do
  if util.path_exists(item.path) then
    io.write("Removing " .. item.path .. "\n")
    if not util.rm_rf(item.path) then
      io.stderr:write("  failed: " .. item.path .. "\n")
      failed = failed + 1
    end
  end
end

if failed > 0 then
  io.stderr:write("Finished with " .. failed .. " error(s). Neovim is still installed.\n")
  os.exit(1)
end

io.write("MμVim user data is gone. Neovim is still installed.\n")
