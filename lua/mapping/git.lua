local custom = require("mapping.util.extention")
local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- vim-fugitive (git support)
map("n", "<Leader>gpl", ":Git pull<CR>", {})
map("n", "<Leader>gps", ":Git push<CR>", {})
map("n", "<Leader>gii", ":Git init<CR>", {})
map("n", "<Leader>gsh", ":Git show<CR>", {})
map("n", "<Leader>gbl", ":Git blame<CR>", {})
map("n", "<Leader>gc", ":Git commit<CR>", {})
map("n", "<Leader>gst", ":Git status<CR>", {})
map("n", "<Leader>gaa", ":Git add %<CR>", {})
map("n", "<Leader>gap", ":Git add % -p<CR>", {})
map("n", "<Leader>grv", ":Git remote -v<CR>", {})

-- Commands that need specification
map("n", "<Leader>gsw", ":Git switch<Space>", {})
map("n", "<Leader>gco", ":Git checkout<Space>", {})
map("n", "<Leader>gcb", ":Git checkout -b<Space>", {})

-- Custom action
map("n", "<Leader>gll", function()
	custom.HandleGitCustomActions("pull")
end, opts)
map("n", "<Leader>gpp", function()
	custom.HandleGitCustomActions("push")
end, opts)

-- To performe different actions
map("n", "<Leader>ggg", ":Git<Space>", {})
