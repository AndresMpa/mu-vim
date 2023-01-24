local map = vim.api.nvim_set_keymap

-- Plugin manager
map("n", "<Leader>pi", ":PackerInstall<CR>", {})
map("n", "<Leader>pc", ":PackerClean<CR>", {})
map("n", "<Leader>pu", ":PackerSync<CR>", {})
