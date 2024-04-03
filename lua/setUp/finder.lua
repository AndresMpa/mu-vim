local trouble = require("trouble.providers.telescope")
--local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = { ["<C-t>"] = trouble.open_with_trouble },
			n = { ["<C-e>"] = trouble.open_with_trouble },
		},
	},
	pickers = {},
	extensions = {},
})
