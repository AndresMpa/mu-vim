-- SET UP

-- Welcome screen
require('setUp.welcome')

-- MOTION
-- File manager
require('setUp.navigator')

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
