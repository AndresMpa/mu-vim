vim.g.muvim_default_theme = "deep-ocean"

local apply = require("scheme.apply")
apply.restore()

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
