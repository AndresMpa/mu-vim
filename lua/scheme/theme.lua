vim.g.muvim_default_theme = "deep-ocean"

local apply = vim.fn.stdpath("config") .. "/themes/apply.vim"
if vim.fn.filereadable(apply) == 1 then
	vim.cmd.source(apply)
end
