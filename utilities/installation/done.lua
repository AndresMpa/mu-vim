--[[
  utilities/installation/done.lua

  Port of done.sh.
]]

local M = {}

local function term_width()
  local handle = io.popen("tput cols 2>/dev/null < /dev/tty", "r")
  if not handle then return 80 end
  local out = handle:read("*l")
  handle:close()
  local width = tonumber(out)
  return width or 80
end

local function display_len(s)
  return utf8.len(s) or #s
end

local function right_justify(text, field_width)
  local pad = field_width - display_len(text)
  if pad < 0 then pad = 0 end
  return string.rep(" ", pad) .. text
end

-- Split multiline info so each line is justified, matching the bash installer.
local function print_centered_message(title, info)
  local width = term_width()
  local shift = math.floor((display_len(title) + width) / 8)

  io.write(right_justify(title, shift) .. "\n\n\n")

  for line in (info .. "\n"):gmatch("(.-)\n") do
    io.write(right_justify(line, shift) .. "\n")
  end
end

function M.installation_success()
  local title = "Installation is done"
  local info = "It seems that everything is alright, to complete this process enter nvim then let nvim install some extra features.\n"
    .. "If you get an issue try checking mu-vim wiki: https://github.com/AndresMpa/mu-vim/wiki"

  print_centered_message(title, info)
end

function M.installation_wrong()
  local title = "Something went wrong"
  local info = "Try again, if you see this error again, please submit an issue on mu-vim project\n"
    .. "https://github.com/AndresMpa/mu-vim/issues"

  print_centered_message(title, info)
end

return M
