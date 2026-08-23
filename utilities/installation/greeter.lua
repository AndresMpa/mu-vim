--[[
  utilities/installation/greeter.lua

  Puerto de utilities/installation/greeter.sh. Mantiene las mismas fórmulas
  de centrado del original (title_shift usa /8, banner_shift usa /2 — no es
  un typo, así calculaba el bash original y lo dejamos igual para que el
  resultado visual no cambie).
]]

local M = {}

local TITLE = "Hey there, thanks for giving the project a try and welcome to"

local BANNER = {
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⡆⠀⠀⠀⠀⠀⠀⠜⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⢠⠁⢰⠀⠀⠀⠀⢀⠊⢠⠀⠀⢠⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⡆⠀⠀⠠⠃⠀⡘⠀⠀⡘⠀⠀⠀⠀⡘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢰⠀⡰⠁⠀⠀⠇⠀⠀⡇⠀⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠰⠀⠀⠀⠀⠞⠀⠀⠀⠰⠀⠀⢰⠑⠤⠤⠔⠱⠀⣿⡆⠀⠀⠀⣾⡗⠀⠀⠰⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⠀⠀⠀⠀⠀⠀⠸⣿⡄⠀⣸⣿⠁⠀⣴⣶⣶⡄⠀⠀⢰⣦⣶⣤⣴⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣷⢠⣿⠇⠀⠀⠀⠀⣿⡇⠀⠀⢸⣿⠀⣿⡏⠈⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⡟⠀⠀⠀⠀⠀⣿⡇⠀⠀⢸⣿⠀⣿⡇⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠿⠁⠀⠀⠀⠀⠀⠿⠿⠿⠀⠸⠟⠀⠻⠇⠀⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}

-- Ancho de terminal vía `tput cols`; si no hay tty o falla, 80 por defecto
-- (mismo fallback que el bash original).
local function term_width()
  local handle = io.popen("tput cols 2>/dev/null < /dev/tty", "r")
  if not handle then return 80 end
  local out = handle:read("*l")
  handle:close()
  local width = tonumber(out)
  return width or 80
end

-- Longitud en caracteres UTF-8 (no bytes) para que el braille art del
-- banner, cuyos glifos ocupan varios bytes cada uno, se centre igual que
-- en bash bajo un locale UTF-8.
local function display_len(s)
  return utf8.len(s) or #s
end

-- printf '%*s' right-justifies `text` inside a field of width `field_width`,
-- i.e. it pads with (field_width - len(text)) spaces, NOT `field_width`
-- spaces followed by the text. Replicated here explicitly since Lua has no
-- direct equivalent to bash's `%*s`.
local function right_justify(text, field_width)
  local pad = field_width - display_len(text)
  if pad < 0 then pad = 0 end
  return string.rep(" ", pad) .. text
end

function M.greeter()
  local width = term_width()
  local title_shift = math.floor((display_len(TITLE) + width) / 8)
  local banner_shift = math.floor((display_len(BANNER[1]) + width) / 2)

  io.write(right_justify(TITLE, title_shift) .. "\n")

  for _, line in ipairs(BANNER) do
    io.write(right_justify(line, banner_shift) .. "\n")
  end

  return true
end

return M
