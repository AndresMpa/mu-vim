-- LSP config

local function safe_require(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify(
      string.format(
        "mu-vim: '%s' not loaded yet. Use :Pckr Sync then exit and open again.\n%s",
        mod,
        err
      ),
      vim.log.levels.WARN
    )
  end
  return ok
end

safe_require("lsp.server")
safe_require("lsp.linter")
safe_require("lsp.formatter")
safe_require("lsp.completion")
safe_require("lsp.capabilities")
