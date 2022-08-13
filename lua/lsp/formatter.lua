-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		sh = { require("formatter.filetypes.sh").shfmt },
		css = { require("formatter.filetypes.css").prettier },
		scss = { require("formatter.filetypes.css").prettier },
		less = { require("formatter.filetypes.css").prettier },
		html = { require("formatter.filetypes.html").prettier },
		json = { require("formatter.filetypes.json").prettier },
		yaml = { require("formatter.filetypes.yaml").prettier },
		python = { require("formatter.filetypes.python").autopep8 },
		svelte = { require("formatter.filetypes.svelte").prettier },
		vue = { require("formatter.filetypes.javascript").prettier },
		graphql = { require("formatter.filetypes.graphql").prettier },
		markdown = { require("formatter.filetypes.markdown").prettier },
		angular = { require("formatter.filetypes.javascript").prettier },
		javascript = { require("formatter.filetypes.javascript").prettier },
		typescript = { require("formatter.filetypes.typescript").prettier },
		javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})
