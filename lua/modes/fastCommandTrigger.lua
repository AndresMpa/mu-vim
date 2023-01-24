local libmodal = require("libmodal")

local modes = {
	j = "split",
	k = "vsplit",
}

vim.keymap.set("n", "mmf", function()
	libmodal.mode.enter("FCT", modes)
end, {})
