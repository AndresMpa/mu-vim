-- Instalador mínimo de LSPs, dependency-free, que reemplaza mason.nvim +
-- mason-lspconfig.nvim para servidores basados en Node. Usa pnpm en vez de
-- npm, instala de forma asíncrona (no bloquea Neovim) y llama a
-- vim.lsp.enable() nativo (Neovim 0.11+) cuando el binario ya está listo.
--
-- Requiere: pnpm en el PATH. Nada de node/npm real necesario aparte de eso.
--
-- USO en tu init.lua o lsp/init.lua:
--
--   require("lsp.pnpm_installer").setup({
--     "bashls", "jsonls", "cssls", "html", "eslint",
--     "ts_ls", "tailwindcss", "yamlls",
--   })
--
-- Instalación manual puntual:
--   :PnpmLspInstall bashls
--
-- Para agregar un server nuevo, añade una entrada a M.registry abajo.

local M = {}

---@class ServerSpec
---@field pkg string  -- uno o más paquetes pnpm (separados por espacio)
---@field bin string  -- binario a verificar/ejecutar en PATH

-- Registro: nombre lspconfig -> paquete(s) pnpm + binario resultante.
-- Cubre los servers Node-based más comunes. Agrega los que necesites.
M.registry = {
  bashls = { pkg = "bash-language-server", bin = "bash-language-server" },
  jsonls = { pkg = "vscode-langservers-extracted", bin = "vscode-json-language-server" },
  cssls = { pkg = "vscode-langservers-extracted", bin = "vscode-css-language-server" },
  html = { pkg = "vscode-langservers-extracted", bin = "vscode-html-language-server" },
  eslint = { pkg = "vscode-langservers-extracted", bin = "vscode-eslint-language-server" },
  ts_ls = { pkg = "typescript-language-server typescript", bin = "typescript-language-server" },
  tailwindcss = { pkg = "@tailwindcss/language-server", bin = "tailwindcss-language-server" },
  yamlls = { pkg = "yaml-language-server", bin = "yaml-language-server" },
  dockerls = { pkg = "dockerfile-language-server-nodejs", bin = "docker-langserver" },
  svelte = { pkg = "svelte-language-server", bin = "svelteserver" },
  astro = { pkg = "@astrojs/language-server", bin = "astro-ls" },
  angularls = { pkg = "@angular/language-server", bin = "ngserver" },
  sqlls = { pkg = "sql-language-server", bin = "sql-language-server" },
  vimls = { pkg = "vim-language-server", bin = "vim-language-server" },
  emmet_ls = { pkg = "emmet-ls", bin = "emmet-ls" },
}

local function is_installed(bin)
  return vim.fn.executable(bin) == 1
end

local function install_async(name, spec, on_done)
  vim.notify(("[pnpm-lsp] instalando %s (%s)..."):format(name, spec.pkg), vim.log.levels.INFO)

  local args = { "add", "-g" }
  for pkg in spec.pkg:gmatch("%S+") do
    table.insert(args, pkg)
  end

  vim.system(vim.list_extend({ "pnpm" }, args), { text = true }, function(result)
    vim.schedule(function()
      if result.code == 0 then
        vim.notify(("[pnpm-lsp] %s instalado correctamente"):format(name), vim.log.levels.INFO)
      else
        vim.notify(
          ("[pnpm-lsp] fallo instalando %s:\n%s"):format(name, result.stderr or "(sin salida)"),
          vim.log.levels.ERROR
        )
      end
      if on_done then
        on_done(result.code == 0)
      end
    end)
  end)
end

--- Instala (si hace falta) y habilita los servers indicados.
---@param servers string[] nombres lspconfig, ej. {"bashls", "jsonls"}
function M.setup(servers)
  if vim.fn.executable("pnpm") == 0 then
    vim.notify("[pnpm-lsp] pnpm no está en el PATH, no se puede instalar nada", vim.log.levels.ERROR)
    return
  end

  for _, name in ipairs(servers) do
    local spec = M.registry[name]
    if not spec then
      vim.notify(("[pnpm-lsp] %s no está en el registry, agrégalo a M.registry"):format(name), vim.log.levels.WARN)
    elseif is_installed(spec.bin) then
      vim.lsp.enable(name)
    else
      install_async(name, spec, function(ok)
        if ok then
          vim.lsp.enable(name)
        end
      end)
    end
  end
end

-- Comando manual: :PnpmLspInstall <server>  (con autocompletado)
vim.api.nvim_create_user_command("PnpmLspInstall", function(opts)
  local name = opts.args
  local spec = M.registry[name]
  if not spec then
    vim.notify("Servidor desconocido: " .. name, vim.log.levels.ERROR)
    return
  end
  install_async(name, spec, function(ok)
    if ok then
      vim.lsp.enable(name)
    end
  end)
end, {
  nargs = 1,
  complete = function()
    local names = {}
    for k in pairs(M.registry) do
      table.insert(names, k)
    end
    table.sort(names)
    return names
  end,
})

return M
