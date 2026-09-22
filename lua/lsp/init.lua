-- LSP config

local function safe_require(mod)
  local ok = pcall(require, mod)
  return ok
end

safe_require("lsp.capabilities")
safe_require("lsp.server")
safe_require("lsp.linter")
safe_require("lsp.formatter")
safe_require("lsp.completion")
safe_require("lsp.alias")
