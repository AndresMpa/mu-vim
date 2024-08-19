local trouble = require("trouble.sources.telescope")
--local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = { ["<C-t>"] = trouble.open },
			n = { ["<C-e>"] = trouble.open },
		},
	},
	pickers = {},
	extensions = {},
})
