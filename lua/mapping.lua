-- Set new keymap
local map = vim.api.nvim_set_keymap

-- Leader Key
vim.g.mapleader = " "

-- easymotion
map("n", "<Leader>ss", "<Plug>(easymotion-s2)", {})

-- bufferline
map("n", "<Leader>mk", ":BufferLineMoveNext<CR>", {})
map("n", "<Leader>mj", ":BufferLineMovePrev<CR>", {})

-- incsearch
map("n", "/", "<Plug>(incsearch-forward)", {})
map("n", "?", "<Plug>(incsearch-backward)", {})

-- NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", {})

-- Telescope
map("n", "<Leader>t", ":Telescope<CR>", {})
map("n", "<Leader>tf", ":Telescope fd<CR>", {})
map("n", "<Leader>tt", ":Telescope live_grep<CR>", {})
map("n", "<Leader>ts", ":Telescope grep_string<CR>", {})

-- vCoolor
map("n", "<Leader>r", ":VCoolIns ra", {})

-- Formatter
map("n", "<leader>f", ":Format<CR>", {})

-- vim-fugitive (git support)
map("n", "<Leader>gpl", ":Git pull<CR>", {})
map("n", "<Leader>gps", ":Git push<CR>", {})
map("n", "<Leader>gii", ":Git init<CR>", {})
map("n", "<Leader>gsh", ":Git show<CR>", {})
map("n", "<Leader>gbl", ":Git blame<CR>", {})
map("n", "<Leader>gc", ":Git commit<CR>", {})
map("n", "<Leader>gst", ":Git status<CR>", {})
map("n", "<Leader>gaa", ":Git add --all<CR>", {})
map("n", "<Leader>grv", ":Git remote -v<CR>", {})

-- Commands that need especification
map("n", "<Leader>ga", ":Git add<Space>", {})
map("n", "<Leader>gsw", ":Git switch<Space>", {})
map("n", "<Leader>gco", ":Git checkout<Space>", {})
map("n", "<Leader>gcb", ":Git checkout -b<Space>", {})
map("n", "<Leader>gll", ":Git pull origin<Space>", {})
map("n", "<Leader>gpp", ":Git push origin<Space>", {})

-- To performe different actions
map("n", "<Leader>ggg", ":Git<Space>", {})

-- Plugin manager
map("n", "<Leader>pi", ":PackerInstall<CR>", {})
map("n", "<Leader>pc", ":PackerClean<CR>", {})
map("n", "<Leader>pu", ":PackerSync<CR>", {})

-- Natives
map("n", "<Leader>w", ":w<CR>", {})
map("n", "<Leader>q", ":q!<CR>", {})
-- Replace
map("n", "<Leader>R", ":%s/_/_/gc", {})
-- Tabs motion
map("n", "<Leader>k", ":bnext<CR>", {})
map("n", "<Leader>h", ":bdelete!<CR>", {})
map("n", "<Leader>j", ":bprevious<CR>", {})
-- Buffers control
map("n", "<Leader>H", ":%bd | e# | bd#<CR>", {})
-- Split control
map("n", "<Leader>vv", ":on<CR>", {})
map("n", "<Leader>vj", ":split<CR>", {})
map("n", "<Leader>vk", ":vsplit<CR>", {})
-- Window
map("n", "<Leader><", ':exe "resize " . (winheight(0) * 3/2)<CR>', {})
map("n", "<Leader>>", ':exe "resize " . (winheight(0) * 2/3)<CR>', {})
-- Folding
map("v", "f", "zf<CR>", {})
map("n", "f", "za<CR>", {})

-- Extentions
map("n", "<Leader>hh", "<CMD>lua require('util.extention').HelpMapping()<CR>", {})
map("n", "<Leader>x", "<CMD>lua require('util.extention').OpenFileServer()<CR>", {})

-- Terminal
map("n", "<C-t>", "<CMD>lua require('util.extention').OpenTerminal()<CR>", { noremap = true })
