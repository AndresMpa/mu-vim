-- SET UP

-- Welcome screen
require('setUp.alpha')

-- MOTION
-- File manager
require('setUp.nvimTree')

-- Multitab
require("bufferline").setup{}

-- THEME
-- Nvim
require('scheme.material')

-- Bar
require('setUp.lualine')

-- Highlighting
require('setUp.treesitter')

-- Highlighter
require('colorizer').setup()
