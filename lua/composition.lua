-- SET UP

-- Welcome screen
require('setUp.alpha')

-- MOTION
-- File manager
require('setUp.nvimTree')

-- Multitab
require('setUp.bufferline')

-- Snippets
require('setUp.snippets')

-- THEME
-- Nvim
require('scheme.material')

-- Bar
require('setUp.lualine')

-- Highlighting
require('setUp.treesitter')

-- Identation
require('setUp.identBlankline')

-- Highlighter
require('colorizer').setup()
