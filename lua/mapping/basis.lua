-- Options
local opts = { noremap = true, silent = true }
-- Set new keymap
local map = vim.api.nvim_set_keymap

-- Natives
map("n", "<Leader>w", ":w<CR>", {})
map("n", "<Leader>q", ":q!<CR>", {})
-- Replace
map("n", "<Leader>R", ":%s/_/_/gc", {})
map("n", "U", "<C-r>", {})
-- Tabs motion
map("n", "<Leader>k", ":bnext<CR>", {})
map("n", "<Leader>h", ":bdelete!<CR>", {})
map("n", "<Leader>j", ":bprevious<CR>", {})
map("n", "K", "<C-u>", {})
map("n", "J", "<C-d>", {})
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
