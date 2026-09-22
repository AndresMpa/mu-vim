-- Mason hardcodes `npm`. Without a system npm package we put an npm→pnpm
-- shim first on PATH (also written by install.lua).
local function path_prepend(dir)
  if dir and dir ~= "" and vim.fn.isdirectory(dir) == 1 then
    local path = vim.env.PATH or ""
    if not path:find(dir, 1, true) then
      vim.env.PATH = dir .. ":" .. path
    end
  end
end

local function ensure_npm_shim()
  if vim.fn.executable("pnpm") ~= 1 then
    return false
  end
  -- Prefer a real npm when it exists and is not our shim.
  local shim_dir = vim.fn.stdpath("data") .. "/muvim/bin"
  local shim = shim_dir .. "/npm"
  if vim.fn.executable("npm") == 1 then
    local npm = vim.fn.exepath("npm")
    if npm ~= "" and not npm:find("/muvim/bin/npm", 1, true) then
      return true
    end
  end
  vim.fn.mkdir(shim_dir, "p")
  local lines = {
    "#!/usr/bin/env bash",
    "# npm → pnpm shim for Mason (mason.nvim always spawns `npm`).",
    "set -e",
    'if ! command -v pnpm >/dev/null 2>&1; then',
    '  echo "npm-shim: pnpm not found on PATH" >&2',
    "  exit 127",
    "fi",
    'if [ "$1" = "version" ]; then',
    '  for a in "$@"; do',
    '    if [ "$a" = "--json" ]; then',
    [[      node_v="$(node -v 2>/dev/null | sed 's/^v//')"]],
    [[      pnpm_v="$(pnpm -v 2>/dev/null || echo 0.0.0)"]],
    [[      printf '{"npm":"%s","node":"%s","pnpm":"%s"}\n' "${pnpm_v}" "${node_v:-0.0.0}" "${pnpm_v}"]],
    "      exit 0",
    "    fi",
    "  done",
    "fi",
    'if [ "$1" = "init" ]; then',
    "  if [ ! -f package.json ]; then",
    [[    printf '%s\n' '{"name":"@mason/root","version":"1.0.0","private":true}' > package.json]],
    "  fi",
    "  exit 0",
    "fi",
    'exec pnpm "$@"',
  }
  vim.fn.writefile(lines, shim)
  vim.fn.setfperm(shim, "rwxr-xr-x")
  path_prepend(shim_dir)
  return vim.fn.executable("npm") == 1
end

path_prepend(vim.fn.stdpath("data") .. "/mason/bin")
path_prepend(vim.fn.expand("~/.local/share/pnpm"))
path_prepend(vim.fn.expand("~/.local/bin"))
path_prepend("/usr/local/bin")
ensure_npm_shim()
path_prepend(vim.fn.stdpath("data") .. "/muvim/bin")

local has_pnpm = vim.fn.executable("pnpm") == 1
local has_npm = vim.fn.executable("npm") == 1

require("mason").setup({
  PATH = "prepend",

  pip = {
    upgrade_pip = true,
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

if not has_pnpm then
  vim.schedule(function()
    vim.notify(
      "Mason JS language servers need pnpm on PATH (Arch: sudo pacman -S pnpm)",
      vim.log.levels.WARN
    )
  end)
end

require("mason-lspconfig").setup({
  ensure_installed = (has_pnpm or has_npm) and servers or {
    "lua_ls",
    "bashls",
    "clangd",
    "marksman",
    "rust_analyzer",
    "jedi_language_server",
  },
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
