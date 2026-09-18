-- Plugin setups. Each require is optional so a first launch without
-- :Pckr sync still opens an editor instead of aborting.

local function try(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify(
      string.format("mu-vim: %s not ready yet (%s)", mod, err:match("^[^\n]+") or err),
      vim.log.levels.WARN
    )
  end
end

try("lsp")
try("setUp.greeter")
try("scheme.theme")
try("setUp.statusLine")
try("setUp.highligth")
try("setUp.identation")
try("setUp.fileManager")
try("setUp.buffer")
try("setUp.finder")
try("setUp.autosave")
