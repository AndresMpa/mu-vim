vim.g.muvim_default_theme = "deep-ocean"

local apply = require("scheme.apply")
apply.restore()

-- Highlights set during init.lua are reset when the UI attaches.
local group = vim.api.nvim_create_augroup("MuvimThemeRestore", { clear = true })
local opts = {
	group = group,
	nested = true,
	callback = function()
		require("scheme.apply").restore()
	end,
}
if not pcall(vim.api.nvim_create_autocmd, { "UIEnter", "VimEnter" }, opts) then
	vim.api.nvim_create_autocmd("VimEnter", opts)
end

vim.api.nvim_create_user_command("MuvimTheme", function(opts)
	local name = opts.args
	if name == "" then
		require("scheme.picker").open()
		return
	end
	apply.apply(name)
end, {
	nargs = "?",
	complete = function()
		return require("scheme.apply").names()
	end,
})
