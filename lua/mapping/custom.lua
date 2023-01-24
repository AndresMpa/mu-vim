-- Options
local opts = { noremap = true, silent = true }
-- Set new keymap
local map = vim.api.nvim_set_keymap

-- vCoolor
map("n", "<Leader>r", ":VCoolIns ra<CR>", {})

-- Auto save
map("n", "<leader>aw", ":ASToggle<CR>", {})

-- Formatter
map("n", "<leader>f", ":Format<CR>", {})

-- Extentions
map("n", "<Leader>hh", "<CMD>lua require('mapping.util.extention').HelpMapping()<CR>", {})
map("n", "<Leader>x", "<CMD>lua require('mapping.util.extention').OpenFileServer()<CR>", {})

-- Terminal
map("n", "<C-t>", "<CMD>lua require('mapping.util.extention').OpenTerminal()<CR>", opts)
