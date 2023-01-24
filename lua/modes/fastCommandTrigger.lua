local execute = vim.api.nvim_command
local libmodal = require("libmodal")

local fct = {
	f = function()
		execute(":PackerInstall")
	end,
	d = function()
		execute(":PackerClean")
	end,
	s = function()
		execute(":PackerSync")
	end,
	v = function()
		execute(":Mason")
	end,
	c = function()
		execute(":MasonLog")
	end,
}

vim.keymap.set("n", "mmf", function()
	libmodal.mode.enter("FAST-COMMAND-TRIGGER", fct)
end, {})
