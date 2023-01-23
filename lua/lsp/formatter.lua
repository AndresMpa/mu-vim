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

		javascript = { require("formatter.filetypes.javascript").prettier },
		typescript = { require("formatter.filetypes.typescript").prettier },

		html = { require("formatter.filetypes.html").prettier },
		markdown = { require("formatter.filetypes.markdown").prettier },

		css = { require("formatter.filetypes.css").prettier },
		scss = { require("formatter.filetypes.css").prettier },
		less = { require("formatter.filetypes.css").prettier },

		yaml = { require("formatter.filetypes.yaml").prettier },
		json = { require("formatter.filetypes.json").prettier },

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
