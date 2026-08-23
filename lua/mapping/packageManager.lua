local map = vim.keymap.set

-- Plugin manager
map("n", "<Leader>pi", ":Pckr install<CR>", {})
map("n", "<Leader>pc", ":Pckr clean<CR>", {})
map("n", "<Leader>pu", ":Pckr sync<CR>", {})
