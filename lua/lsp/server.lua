require("mason").setup({
  PATH = "append",

  pip = {
    upgrade_pip = true,
  },

  npm = {
    package_manager = "pnpm",
  },

  ui = {
    icons = {
      package_pending = "",
      package_installed = "",
      package_uninstalled = "",
    },
  },
})

local servers = {
  "efm",
  "astro",
  "sqlls",
  "taplo",
  "vimls",
  "vuels",
  "yamlls",
  "svelte",
  "jsonls",
  "lua_ls",
  "eslint",
  "bashls",
  "clangd",
  "emmet_ls",
  "dockerls",
  "marksman",
  "ts_ls",
  "grammarly",
  "angularls",
  "tailwindcss",
  "diagnosticls",
  "rust_analyzer",
  "jedi_language_server",
}

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local defaults = {}

local configs = {

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },

  ts_ls = {
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  },
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, vim.tbl_deep_extend("force", defaults, configs[server] or {}))

  vim.lsp.enable(server)
end
