local custom = require("mapping.util.extention")
-- Set new keymap
local map = vim.keymap.set

-- Options
local opts = { noremap = true, silent = true }

-- vCoolor
map("n", "<Leader>r", ":VCoolIns ra<CR>", {})

-- Auto save
map("n", "<leader>aw", ":ASToggle<CR>", {})

-- Formatter
map("n", "<leader>f", ":Format<CR>", {})

-- Extentions
map("n", "<Leader>hh", ":Telescope keymaps<CR>", {})
map("n", "<Leader>th", function()
	require("scheme.picker").open()
end, {})

map("n", "<Leader>x", function()
	custom.OpenFileServer()
end, {})

-- Terminal
map("n", "<C-t>", function()
	custom.OpenTerminal()
end, opts)
