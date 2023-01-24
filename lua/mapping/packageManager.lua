local map = vim.keymap.set

-- Plugin manager
map("n", "<Leader>pi", ":PackerInstall<CR>", {})
map("n", "<Leader>pc", ":PackerClean<CR>", {})
map("n", "<Leader>pu", ":PackerSync<CR>", {})
