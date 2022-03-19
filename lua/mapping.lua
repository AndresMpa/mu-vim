--==[ Key Bindings ]==--

-- Set new keymap
local map = vim.api.nvim_set_keymap

-- Leader Key
vim.g.mapleader = ' '

-- Settings commands

-- easymotion
map('n', '<Leader>ss', '<Plug>(easymotion-s2)', {})

-- Files
map('n', '<Leader>sf', ':BLines<CR>', {})

-- bufferline
map('n', '<Leader>mk', ":BufferLineMoveNext", {})
map('n', '<Leader>mj', ":BufferLineMovePrev", {})

-- incsearch
map('n', '/', '<Plug>(incsearch-forward)', {})
map('n', '?', '<Plug>(incsearch-backward)', {})

-- NERDTree
map('n', '<leader>n', ':NvimTreeToggle<CR>', {})

-- fzf
map('n', '<Leader>ff', ':Ag<CR>', {})
map('n', '<Leader>ft', ':FZF<CR>', {})

-- AcK
map('n', '<Leader>a', ':Ack<Space>', {})

-- vCoolor
map('n', '<Leader>r', ':VCoolIns ra', {})

-- Replace
map('n', '<Leader>R', ':%s/_/_/gc', {})

-- vim-fugitive (git support)
map('n', '<Leader>gpl', ':Git pull<CR>', {})
map('n', '<Leader>gps', ':Git push<CR>', {})
map('n', '<Leader>gii', ':Git init<CR>', {})
map('n', '<Leader>gsh', ':Git show<CR>', {})
map('n', '<Leader>gbl', ':Git blame<CR>', {})
map('n', '<Leader>gst', ':Git status<CR>', {})
map('n', '<Leader>gc', ':Git commit<CR>', {})
map('n', '<Leader>gaa', ':Git add --all<CR>', {})
map('n', '<Leader>grv', ':Git remote -v<CR>', {})

-- Commands that need especification
map('n', '<Leader>ga', ':Git add<Space>', {})
map('n', '<Leader>gsw', ':Git switch<Space>', {})
map('n', '<Leader>gco', ':Git checkout<Space>', {})
map('n', '<Leader>gcb', ':Git checkout -b<Space>', {})
map('n', '<Leader>gll', ':Git pull origin<Space>', {})
map('n', '<Leader>gpp', ':Git push origin<Space>', {})

-- To performe different actions
map('n', '<Leader>ggg', ':Git<Space>', {})

-- coc
map('n', '<silent>cd', '<Plug>(coc-definition)', {})
map('n', '<silent>ct', '<Plug>(coc-type-definition)', {})
map('n', '<silent>cg', '<Plug>(coc-implementation)', {})
map('n', '<silent>cr', '<Plug>(coc-references)', {})
-- Use <c-space> to trigger completion.
map('n', '<silent><expr> <c-space>', 'coc#refresh()', {})

-- Plug
map('n', '<Leader>pc', ':PlugClean<CR>', {})
map('n', '<Leader>pi', ':PlugInstall<CR>', {})
map('n', '<Leader>pu', ':PlugUpdate<CR>', {})
map('n', '<Leader>pd', ':PlugUpgrade<CR>', {})

-- Extras
map('n', '<Leader>w', ':w<CR>', {})
map('n', '<Leader>q', ':q!<CR>', {})
map('n', '<Leader>h', ':bdelete<CR>', {})
map('n', '<Leader>j', ':bprevious<CR>', {})
map('n', '<Leader>k', ':bnext<CR>', {})
map('n', '<Leader>b', ':Buffers<CR>', {})
map('n', '<Leader>l', ':ls<CR>', {})
map('n', '<Leader>vj', ':split<CR>', {})
map('n', '<Leader>vk', ':vsplit<CR>', {})
map('n', '<Leader><', ':exe "resize " . (winheight(0) * 3/2)<CR>', {})
map('n', '<Leader>>', ':exe "resize " . (winheight(0) * 2/3)<CR>', {})


-- Extentions

-- Type something
map('n', '<Leader>hh', '[[<Cmd>lua require(util.extention)HelpMapping()<CR>]]', {})
map('n', '<Leader>x', ':call OpenFileServer()<CR>', {})

map('n', '<Leader>xd', ":call OpenServer('django')<CR>", {})
map('n', '<Leader>xv', ":call OpenServer('vue')<CR>", {})

map('n', '<leader>f', ':call TriggerIdentation()<CR>', {})

map('n', '<C-t>', ':call OpenTerminal()<CR>', {})
