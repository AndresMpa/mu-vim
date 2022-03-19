--==[ Plugins ]==--
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- START SCREEN
Plug 'goolord/alpha-nvim'                                   -- First view

-- Bar
Plug 'kyazdani42/nvim-web-devicons'                         -- Icons font
Plug 'nvim-lualine/lualine.nvim'                            -- Status line
Plug 'akinsho/bufferline.nvim'                              -- Files openned

-- Nvim
--Plug('morhetz/gruvbox', { 'as' = 'gruvbox' })	            -- Nvim theme
--Plug 'kamykn/dark-theme.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'marko-cerovac/material.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

-- MOTION
Plug 'christoomey/vim-tmux-navigator'				                              -- Navigation between windows
Plug 'easymotion/vim-easymotion'						                              -- Navigation in files
Plug 'haya14busa/incsearch.vim'							                              -- Better way to look for words
Plug 'junegunn/fzf.vim'                                                   -- Better way to search files
Plug 'mileszs/ack.vim'                                                    -- Navigation in projects

--IDENTATION & SYNTAX

Plug ('neoclide/coc.nvim', {branch = 'release'})    -- Text editing support
Plug 'leafgarland/typescript-vim'                   -- TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'                     -- JS and JSX syntax
Plug 'pangloss/vim-javascript'                      -- JavaScript support
Plug 'sheerun/vim-polyglot'		                      -- Syntax highligth for multiple languajes
Plug 'Yggdroot/indentLine'                          -- Identation helper (It shows the identation of functions, etc)
Plug 'folke/trouble.nvim'                           -- Help to find issues
Plug 'tpope/vim-fugitive'                           -- Support to git commands
Plug 'z0mbix/vim-shfmt'                             -- Identation for bash scripts


-- UTILITIES

Plug 'iamcco/markdown-preview.nvim'               -- Markdown preview
Plug 'terryma/vim-multiple-cursors'               -- Multicursor
Plug 'preservim/nerdcommenter'                    -- Easy way to make commets
Plug 'KabbAmine/vCoolor.vim'                      -- Color picker for css
Plug 'turbio/bracey.vim'                          -- Vim live server
Plug 'mhinz/vim-signify'                          -- Git diffs
Plug 'ap/vim-css-color'                           -- Show #fffffffff with colors
Plug 'tpope/vim-repeat'                           -- Repat all the commands using dot key

-- AUTOCOMPLETE

Plug 'editorconfig/editorconfig-vim'              -- It gives nvim a general editing config for identation
Plug 'jiangmiao/auto-pairs'                       -- Autocomplete parentesis
Plug 'tpope/vim-surround'                         -- It helps to 'CRUD' parentesis, comillas and tags
Plug 'alvan/vim-closetag'                         -- Autocomplete tags
Plug 'sirver/ultisnips'                           -- Snippers engine

vim.call('plug#end')
