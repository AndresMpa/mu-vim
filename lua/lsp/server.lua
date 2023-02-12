require("mason").setup({
	ui = {
		icons = {
			package_pending = "",
			package_installed = "",
			package_uninstalled = "",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
})

local lspMapping = require("../mapping/lsp")
require("mason-lspconfig").setup_handlers({
	-- Default configuration
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = lspMapping.on_attach,
			flags = lspMapping.lsp_flags,
		})
	end,
	-- Lua configuration
	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
	-- JS/TS configuration
	["tsserver"] = function()
		require("lspconfig").tsserver.setup({
			init_options = {
				preferences = {
					disableSuggestions = true,
				},
			},
		})
	end,
})
