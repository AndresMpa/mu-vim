-- Utilities for creating configurations
--local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		sh = { require("formatter.filetypes.sh").shfmt },

		css = { require("formatter.filetypes.css").rome },
		html = { require("formatter.filetypes.html").rome },
		json = { require("formatter.filetypes.json").rome },
		markdown = { require("formatter.filetypes.markdown").rome },
		javascript = { require("formatter.filetypes.javascript").rome },
		typescript = { require("formatter.filetypes.typescript").rome },

		scss = { require("formatter.filetypes.css").prettier },
		less = { require("formatter.filetypes.css").prettier },
		yaml = { require("formatter.filetypes.yaml").prettier },
		svelte = { require("formatter.filetypes.svelte").prettier },
		vue = { require("formatter.filetypes.javascript").prettier },
		graphql = { require("formatter.filetypes.graphql").prettier },
		angular = { require("formatter.filetypes.javascript").prettier },
		javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },

		python = { require("formatter.filetypes.python").autopep8 },

		lua = { require("formatter.filetypes.lua").stylua },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
