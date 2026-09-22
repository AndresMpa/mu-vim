require("mason").setup({
  PATH = "append",

  pip = {
    upgrade_pip = true,
  },

  -- Mason names this key "npm"; the manager we actually run is pnpm.
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

local ok_caps, capabilities = pcall(require, "lsp.capabilities")
if not ok_caps then
  capabilities = vim.lsp.protocol.make_client_capabilities()
end

local defaults = {
  capabilities = capabilities,
}

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
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    init_options = {
      preferences = {
        disableSuggestions = true,
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, vim.tbl_deep_extend("force", defaults, configs[server] or {}))

  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("muvim_lsp_attach", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true, noremap = true }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, opts)
    vim.keymap.set("n", "gi", function()
      vim.lsp.buf.implementation()
    end, opts)
    vim.keymap.set("n", "gr", function()
      vim.lsp.buf.references()
    end, opts)
  end,
})

local alias_fts = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "svelte",
  "astro",
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("muvim_path_alias", { clear = true }),
  pattern = alias_fts,
  callback = function()
    pcall(function()
      require("lsp.alias").setup_buffer()
    end)
  end,
})
