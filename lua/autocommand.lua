--Packer
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- DVC
vim.cmd([[
  autocmd! BufNewFile,BufRead Dvcfile,*.dvc,dvc.lock setfiletype yaml
]])

vim.cmd([[
  au BufEnter * set fo-=c fo-=r fo-=o
]])

--Syntax
vim.cmd([[
  syntax enable
]])
