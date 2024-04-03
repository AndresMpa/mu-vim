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
	ensure_installed = {
		"efm", -- General purpose server
		"astro", -- Astro support
		"gopls", -- Go
		"sqlls", -- SQL
		"taplo", -- TOML
		"vimls", -- Vim
		"vuels", -- Vue
		"yamlls", -- YAML
		"svelte", -- Svelte
		"jsonls", -- JSON
		"lua_ls", -- Lua
		"eslint", -- ESLint
		"bashls", -- Bash
		"clangd", -- C/C++
		"emmet_ls", -- Emmet
		"dockerls", -- Docker
		"marksman", -- Markdown
		"tsserver", -- TS/JS
		"grammarly", -- Grammar support
		"angularls", -- Angular support
		"tailwindcss", -- HTML/CSS
		"diagnosticls", -- Diagnostics
		"rust_analyzer", -- Rust
		"jedi_language_server", -- Python
	},
})

local lspMapping = require("../mapping/diagnostics")
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
