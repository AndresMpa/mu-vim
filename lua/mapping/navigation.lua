local map = vim.api.nvim_set_keymap

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