--Packer
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

vim.cmd([[
    au BufEnter * set fo-=c fo-=r fo-=o
]])

--Auto save
vim.cmd([[
    autocmd CursorHold, CursorHoldI * update
]])

vim.cmd([[
  syntax enable
]])

--[[ Unnecesary since I moved it to LSP ]]--
--[[vim.cmd([[]]
    --[[autocmd BufNewFile,BufRead *.html set ft=html]]
--[[<])]]


--[[ Too annoying
vim.api.nvim_create_augroup("lsp_completion_group", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	group = "lsp_completion_group",
  callback = vim.lsp.buf.hover
})
]]--
