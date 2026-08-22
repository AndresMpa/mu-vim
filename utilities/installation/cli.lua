--[[
  utilities/installation/cli.lua

  Widgets de terminal reutilizables al estilo "npm init": un menú de
  selección única y una checklist de selección múltiple, ambos navegables
  con las flechas ↑/↓ y confirmados con Enter (la checklist además usa
  Espacio para marcar/desmarcar). También incluye un prompt de texto plano.

  Lua puro no tiene binding a termios/ioctl, así que el modo "raw" de la
  terminal se activa/desactiva invocando `stty` como subproceso. Esto
  limita el CLI a sistemas tipo Unix con `stty` disponible (igual que el
  install.sh original, que ya asumía bash + coreutils).
]]

local M = {}

local ESC = string.char(27)

local function stty(args)
  os.execute("stty " .. args .. " < /dev/tty 2>/dev/null")
end

local function enable_raw_mode()
  -- -echo: no repetir en pantalla lo que se teclea (lo dibujamos nosotros)
  -- -icanon: leer tecla por tecla en vez de esperar una línea completa
  stty("-echo -icanon min 1 time 0")
end

local function disable_raw_mode()
  stty("sane")
end

local tty_handle = nil
local function tty()
  tty_handle = tty_handle or io.open("/dev/tty", "r")
  return tty_handle
end

-- Lee una sola "tecla lógica" de /dev/tty, resolviendo las secuencias de
-- escape de las flechas (ESC [ A/B/C/D) a "up"/"down"/"right"/"left".
-- Ctrl-C restaura la terminal y aborta el instalador en el acto: dejar
-- la terminal en raw mode tras un Ctrl-C es la forma clásica de dejarla
-- "rota" para el resto de la sesión del usuario.
local function read_key()
  local input = tty()
  local c = input:read(1)
  if c == nil then
    return "enter" -- EOF (p.ej. stdin no interactivo): no colgar el proceso
  end
  if c == ESC then
    local c2 = input:read(1)
    if c2 == "[" then
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
    disable_raw_mode()
    io.write("\n")
    os.exit(130)
  else
    return c
  end
end

local function move_cursor_up(n)
  if n > 0 then io.write(ESC .. "[" .. n .. "A") end
end

local function clear_line()
  io.write(ESC .. "[2K\r")
end

-- --- select: elegir UNA opción --------------------------------------------
--
-- options: array de strings, o de tablas { label = "...", value = ... }.
-- Devuelve (value, label) de la opción elegida.
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

  local index = 1
  local lines_printed = 0

  local function draw()
    move_cursor_up(lines_printed)
    for i, label in ipairs(labels) do
      clear_line()
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
  disable_raw_mode()

  return values[index], labels[index]
end

-- --- confirm: atajo de select para preguntas Sí/No ------------------------
--
-- Devuelve true/false. `default_yes` decide qué opción aparece primero.
function M.confirm(question, default_yes)
  local options
  if default_yes == false then
    options = {
      { label = "No", value = false },
      { label = "Sí", value = true },
    }
  else
    options = {
      { label = "Sí", value = true },
      { label = "No", value = false },
    }
  end
  local value = M.select(question, options)
  return value
end

-- --- multi_select: elegir VARIAS opciones (checklist) ---------------------
--
-- options: array de tablas { label = "...", value = ..., desc = "...",
-- checked = true/false }. `checked` es true por defecto (todo viene
-- pre-seleccionado, como los "extras" recomendados de un instalador).
-- Devuelve un array con los `value` (o `label` si no hay value) de las
-- opciones que quedaron marcadas, respetando el orden original.
function M.multi_select(question, options)
  local checked = {}
  for i, opt in ipairs(options) do
    if opt.checked == nil then
      checked[i] = true
    else
      checked[i] = opt.checked
    end
  end

  local index = 1
  local lines_printed = 0
  local hint = "  (↑/↓ mover · espacio marcar · enter confirmar)"

  local function draw()
    move_cursor_up(lines_printed)
    for i, opt in ipairs(options) do
      clear_line()
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
    clear_line()
    io.write(hint)
    io.flush()
    lines_printed = #options + 1
  end

  io.write(question .. "\n")
  enable_raw_mode()
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
  io.write("\n")
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
-- No necesita raw mode: se deja que la terminal maneje la línea (así el
-- usuario puede usar backspace/flechas de edición normalmente).
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
