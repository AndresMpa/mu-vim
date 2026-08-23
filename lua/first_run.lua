--[[
  lua/first_run.lua

  Corre install.lua (el instalador de dependencias del sistema, en
  utilities/installation/) una sola vez, la primera vez que se abre nvim
  después de clonar mu-vim. Se marca con un archivo en stdpath('data')
  para no volver a preguntar en cada arranque.

  Por qué un :terminal y no jobstart a secas: install.lua usa `stty` para
  poner la terminal en raw mode y leer flechas/espacio tecla por tecla, y
  eso necesita un pty de verdad. jobstart() sin `pty = true` le da al job
  un pipe, no un pty, y stty/estas lecturas fallarían igual que fallaban
  en el smoke test que corrimos sin pty real.
]]

local M = {}

local MARKER = vim.fn.stdpath("data") .. "/mu-vim-installed"
local CONFIG_DIR = vim.fn.stdpath("config")
local INSTALL_SCRIPT = CONFIG_DIR .. "/install.lua"

-- Orden de preferencia: intérpretes de Lua "de sistema" más nuevos primero.
local LUA_CANDIDATES = { "lua5.4", "lua5.3", "lua5.1", "luajit", "lua" }

local function find_lua()
  for _, name in ipairs(LUA_CANDIDATES) do
    if vim.fn.executable(name) == 1 then
      return name
    end
  end
  return nil
end

local function mark_as_run()
  local f = io.open(MARKER, "w")
  if f then
    f:write(tostring(os.time()))
    f:close()
  end
end

function M.run()
  -- Ya se instaló (o ya se intentó) antes: no hacer nada.
  if vim.loop.fs_stat(MARKER) then
    return
  end

  -- No hay install.lua junto al init.lua (p.ej. config armada a mano, sin
  -- el repo completo de mu-vim): no hay nada que correr, y no marcamos
  -- MARKER para no ocultar el hecho de que falta el instalador.
  if vim.fn.filereadable(INSTALL_SCRIPT) == 0 then
    return
  end

  local lua_bin = find_lua()
  if not lua_bin then
    vim.notify(
      "mu-vim: no se encontró un intérprete de Lua (lua5.4/lua5.3/luajit) en PATH; "
        .. "no se pudo correr el instalador. Instálalo y corre a mano:\n  lua5.4 "
        .. INSTALL_SCRIPT,
      vim.log.levels.WARN
    )
    return
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      vim.schedule(function()
        vim.cmd("tabnew")
        vim.fn.termopen({ lua_bin, INSTALL_SCRIPT }, {
          cwd = CONFIG_DIR,
          on_exit = function(_, code)
            mark_as_run()
            if code == 0 then
              vim.notify(
                "mu-vim: instalación completa. Reinicia nvim para cargar los plugins.",
                vim.log.levels.INFO
              )
            else
              vim.notify(
                "mu-vim: el instalador terminó con errores, revisa " .. CONFIG_DIR .. "/fails.log",
                vim.log.levels.WARN
              )
            end
          end,
        })
        -- terminal-mode (no normal-mode) para que las flechas/espacio se
        -- manden al pty en vez de interpretarse como movimiento de cursor.
        vim.cmd("startinsert")
      end)
    end,
  })
end

return M
