require("mason").setup({
	ui = {
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "sumneko_lua" },
})

local mapping = require("lsp.mapping")
require("mason-lspconfig").setup_handlers({
	-- Default configuration
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = mapping.on_attach,
			flags = mapping.lsp_flags,
		})
	end,
	-- Lua configuration
	["sumneko_lua"] = function()
		require("lspconfig").sumneko_lua.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
})
