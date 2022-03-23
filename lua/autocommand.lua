--Packer
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

--CoC
vim.cmd([[
    autocmd FileType json syntax match Comment +\/\/.\+$+
]])

vim.cmd([[
    au BufEnter * set fo-=c fo-=r fo-=o
]])

vim.cmd([[
    autocmd CursorHold, CursorHoldI * update
]])

vim.cmd [[
  syntax enable
]]
