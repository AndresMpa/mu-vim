--[[
  utilities/installation/cli.lua

  Terminal widgets: single-choice menu, checklist, and a plain text prompt.
  Raw mode uses stty on Unix. Windows and other hosts without /dev/tty
  fall back to line input.
]]

local M = {}

local ESC = string.char(27)

local function can_use_raw()
  if package.config:sub(1, 1) == "\\" then
    return false
  end
  local f = io.open("/dev/tty", "r")
  if not f then
    return false
  end
  f:close()
  return true
end

local function stty(args)
  os.execute("stty " .. args .. " < /dev/tty 2>/dev/null")
end

local function enable_raw_mode()
  -- -echo: do not echo keys (we draw them)
  -- -icanon: read one key at a time
  stty("-echo -icanon min 1 time 0")
end

local function disable_raw_mode()
  stty("sane")
end

local tty_handle = nil
local function tty()
  if not tty_handle then
    tty_handle = io.open("/dev/tty", "r")
    if tty_handle then
      tty_handle:setvbuf("no")
    end
  end
  return tty_handle
end

-- Read one key from /dev/tty. Arrow sequences become up/down/left/right.
-- Ctrl-C restores the terminal and exits.
local function read_key()
  local input = tty()
  local c = input:read(1)
  if c == nil then
    return "enter" -- EOF (p.ej. stdin no interactivo): no colgar el proceso
  end
  if c == ESC then
    local c2 = input:read(1)
    -- CSI (ESC [) and SS3 (ESC O) both carry arrow keys on macOS.
    if c2 == "[" or c2 == "O" then
      local c3 = input:read(1)
      if c3 == "A" then return "up" end
      if c3 == "B" then return "down" end
      if c3 == "C" then return "right" end
      if c3 == "D" then return "left" end
    end
    return "esc"
  elseif c == "\r" or c == "\n" then
    return "enter"
  elseif c == " " then
    return "space"
  elseif c == "\3" then
    show_cursor()
    disable_raw_mode()
    io.write("\n")
    os.exit(130)
  else
    return c
  end
end

local function hide_cursor()
  io.write(ESC .. "[?25l")
end

local function show_cursor()
  io.write(ESC .. "[?25h")
end

-- Move to the first line of the last paint and erase downward so a
-- redraw cannot stack leftover Yes/No rows or repeated hints.
local function rewind(n)
  if n > 0 then
    io.write(string.format("%s[%dA%s[1G%s[0J", ESC, n, ESC, ESC))
  end
end

local function finish_widget(n)
  rewind(n)
  show_cursor()
end

-- --- select: pick one option ----------------------------------------------
--
-- options: array de strings, o de tablas { label = "...", value = ... }.
-- Returns (value, label) for the chosen option.
function M.select(question, options)
  local labels, values = {}, {}
  for i, opt in ipairs(options) do
    if type(opt) == "table" then
      labels[i] = opt.label
      values[i] = opt.value
    else
      labels[i] = opt
      values[i] = opt
    end
  end

  if not can_use_raw() then
    io.write(question .. "\n")
    for i, label in ipairs(labels) do
      io.write(string.format("  %d) %s\n", i, label))
    end
    io.write("Choose [1]: ")
    io.flush()
    local answer = io.read("*l")
    local n = tonumber(answer) or 1
    if n < 1 or n > #labels then
      n = 1
    end
    return values[n], labels[n]
  end

  local index = 1
  local lines_printed = 0

  local function draw()
    rewind(lines_printed)
    for i, label in ipairs(labels) do
      if i == index then
        io.write("  " .. ESC .. "[36m❯ " .. label .. ESC .. "[0m\n")
      else
        io.write("    " .. label .. "\n")
      end
    end
    lines_printed = #labels
    io.flush()
  end

  io.write(question .. "\n")
  enable_raw_mode()
  hide_cursor()
  draw()
  while true do
    local key = read_key()
    if key == "up" then
      index = index - 1
      if index < 1 then index = #labels end
      draw()
    elseif key == "down" then
      index = index + 1
      if index > #labels then index = 1 end
      draw()
    elseif key == "enter" then
      break
    end
  end
  finish_widget(lines_printed)
  io.write("  " .. labels[index] .. "\n")
  disable_raw_mode()

  return values[index], labels[index]
end

-- --- confirm: Yes/No shortcut ---------------------------------------------
--
-- Returns true/false. default_yes controls which option is listed first.
function M.confirm(question, default_yes)
  local options
  if default_yes == false then
    options = {
      { label = "No", value = false },
      { label = "Yes", value = true },
    }
  else
    options = {
      { label = "Yes", value = true },
      { label = "No", value = false },
    }
  end
  local value = M.select(question, options)
  return value
end

-- --- multi_select: pick several options (checklist) -----------------------
--
-- options: { label, value, desc, checked }. checked defaults to true.
-- Returns the values that stayed marked, in original order.
function M.multi_select(question, options)
  local checked = {}
  for i, opt in ipairs(options) do
    if opt.checked == nil then
      checked[i] = true
    else
      checked[i] = opt.checked
    end
  end

  if not can_use_raw() then
    io.write(question .. "\n")
    io.write("  (comma-separated numbers to keep; empty keeps the defaults)\n")
    for i, opt in ipairs(options) do
      local mark = (opt.checked ~= false) and "x" or " "
      local desc = opt.desc and (" — " .. opt.desc) or ""
      io.write(string.format("  %d) [%s] %s%s\n", i, mark, opt.label, desc))
    end
    io.write("Keep: ")
    io.flush()
    local answer = io.read("*l") or ""
    local result = {}
    if answer:match("%S") then
      local want = {}
      for n in answer:gmatch("%d+") do
        want[tonumber(n)] = true
      end
      for i, opt in ipairs(options) do
        if want[i] then
          result[#result + 1] = opt.value ~= nil and opt.value or opt.label
        end
      end
    else
      for i, opt in ipairs(options) do
        if opt.checked ~= false then
          result[#result + 1] = opt.value ~= nil and opt.value or opt.label
        end
      end
    end
    return result
  end

  local index = 1
  local lines_printed = 0
  local hint = "  (up/down to move, space to toggle, enter to confirm)"

  local function draw()
    rewind(lines_printed)
    for i, opt in ipairs(options) do
      local box = checked[i] and "[x]" or "[ ]"
      local desc = ""
      if opt.desc then
        desc = "  " .. ESC .. "[2m" .. opt.desc .. ESC .. "[0m"
      end
      if i == index then
        io.write("  " .. ESC .. "[36m❯ " .. box .. " " .. opt.label .. ESC .. "[0m" .. desc .. "\n")
      else
        io.write("    " .. box .. " " .. opt.label .. desc .. "\n")
      end
    end
    io.write(hint .. "\n")
    io.flush()
    lines_printed = #options + 1
  end

  io.write(question .. "\n")
  enable_raw_mode()
  hide_cursor()
  draw()
  while true do
    local key = read_key()
    if key == "up" then
      index = index - 1
      if index < 1 then index = #options end
      draw()
    elseif key == "down" then
      index = index + 1
      if index > #options then index = 1 end
      draw()
    elseif key == "space" then
      checked[index] = not checked[index]
      draw()
    elseif key == "enter" then
      break
    end
  end
  finish_widget(lines_printed)
  disable_raw_mode()

  local result = {}
  for i, opt in ipairs(options) do
    if checked[i] then
      table.insert(result, opt.value ~= nil and opt.value or opt.label)
    end
  end
  return result
end

-- --- text: prompt de texto plano con valor por defecto opcional -----------
--
-- No raw mode: the terminal handles the line so backspace still works.
function M.text(question, default)
  local suffix = default and (" [" .. default .. "]") or ""
  io.write(question .. suffix .. ": ")
  io.flush()
  local answer = io.read("l")
  if answer == nil or answer == "" then
    return default
  end
  return answer
end

return M
