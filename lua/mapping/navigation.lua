local map = vim.keymap.set

-- easymotion
map("n", "<Leader>ss", "<Plug>(easymotion-s2)", {})

-- bufferline
map("n", "<Leader>mk", ":BufferLineMoveNext<CR>", {})
map("n", "<Leader>mj", ":BufferLineMovePrev<CR>", {})

-- NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", {})

-- Telescope
map("n", "<Leader>t", ":Telescope<CR>", {})
map("n", "<Leader>tf", ":Telescope fd<CR>", {})
map("n", "<Leader>tt", ":Telescope live_grep<CR>", {})
map("n", "<Leader>ts", ":Telescope grep_string<CR>", {})
