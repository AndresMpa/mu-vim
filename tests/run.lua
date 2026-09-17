#!/usr/bin/env lua
-- Agnostic mapping tests for MμVim.
--
--   lua tests/run.lua
--   lua tests/run.lua /path/to/mu-vim-mini
--   lua tests/run.lua /path/to/mu-vim-vimscript
--   lua tests/run.lua --all
--
-- Does not load Neovim. Parses Lua and VimScript mapping files.

local function script_dir()
  local src = debug.getinfo(1, "S").source
  if src:sub(1, 1) == "@" then
    src = src:sub(2)
  end
  return src:match("(.*/)") or "./"
end

local here = script_dir()
package.path = here .. "?.lua;" .. package.path

local contract = require("contract")
local extract = require("extract")

local function repo_root()
  return here:gsub("/tests/$", "/"):gsub("/tests$", "/")
end

local function present(set, key)
  if key == "u" then
    return set["U"] or set["u"]
  end
  if key == "j" then
    return set["J"] or set["j"]
  end
  if key == "k" then
    return set["K"] or set["k"]
  end
  return set[key] == true
end

local function check_group(set, group, label)
  local missing = {}
  local ok = 0
  for _, item in ipairs(group) do
    if present(set, item.key) then
      ok = ok + 1
    else
      missing[#missing + 1] = item.key .. " (" .. item.name .. ")"
    end
  end
  local total = #group
  local status = (#missing == 0) and "ok" or "FAIL"
  io.write(string.format("  %-12s %s  %d/%d\n", label, status, ok, total))
  for _, line in ipairs(missing) do
    io.write("    missing  " .. line .. "\n")
  end
  return #missing == 0
end

local function run_one(root)
  local flavor, set = extract.collect(root)
  if not flavor then
    io.write("SKIP  " .. root .. "  (no mapping files)\n")
    return false
  end
  io.write(string.format("[%s]  %s\n", flavor, root))
  local passed = check_group(set, contract.shared, "shared")
  if flavor == "current" then
    passed = check_group(set, contract.current, "current") and passed
  else
    passed = check_group(set, contract.vim_family, "vim-family") and passed
  end
  return passed
end

local function sibling(name)
  return repo_root() .. "../" .. name
end

local targets = {}
if arg[1] == "--all" then
  targets = {
    repo_root(),
    sibling("mu-vim-mini"),
    sibling("mu-vim-vimscript"),
  }
elseif arg[1] then
  targets = { arg[1] }
else
  targets = { repo_root() }
end

local failed = 0
for _, root in ipairs(targets) do
  if not run_one(root) then
    failed = failed + 1
  end
end

if failed > 0 then
  os.exit(1)
end
