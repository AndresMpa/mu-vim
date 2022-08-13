-- SET UP

-- GREETER
require("setUp.greeter")

-- THEME
-- Nvim
require("scheme.material")
-- Bar
require("setUp.statusLine")

-- VISUAL HELP
-- Identation
require("setUp.identation")
-- Spell
require("setUp.spelling")
-- Highlight
require("setUp.highligth")
-- Highlighter (theme)
require("colorizer").setup()

-- NAVIGATION
-- File manager
require("setUp.fileManager")
-- Multitab
require("setUp.buffer")

-- LSP
require("lsp")
