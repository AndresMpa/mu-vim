vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- PLUGIN MANAGER
	use("wbthomason/packer.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-lint")
	use("williamboman/mason.nvim")
	use("mhartington/formatter.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- START SCREEN
	use({
		"goolord/alpha-nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
	})

	-- THEME
	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})

	-- Nvim
	use("norcalli/nvim-colorizer.lua")
	use("marko-cerovac/material.nvim")

	-- Highlight
	use({
		"nvim-treesitter/nvim-treesitter",
		"lewis6991/spellsitter.nvim",
		run = ":TSUpdate",
	})

	-- NAVIGATION
	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})
	-- Files openned
	use("akinsho/bufferline.nvim")

	-- MOTION
	-- Navigation between windows
	use("christoomey/vim-tmux-navigator")
	-- Navigation in files
	use("easymotion/vim-easymotion")
	-- Better way to look for words
	use("haya14busa/incsearch.vim")

	--IDENTATION & SYNTAX
	-- Identation helper (It shows the identation of functions, etc)
	use("lukas-reineke/indent-blankline.nvim")
	-- TypeScript syntax
	use("leafgarland/typescript-vim")
	-- JS and JSX syntax
	use("maxmellon/vim-jsx-pretty")
	-- JavaScript support
	use("pangloss/vim-javascript")
	-- Syntax highligth for multiple languajes
	use("sheerun/vim-polyglot")
	-- Help to find issues
	use("folke/trouble.nvim")
	-- Support to git commands
	use("tpope/vim-fugitive")
	-- Identation for bash scripts
	use("z0mbix/vim-shfmt")

	-- UTILITIES
	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- Live server
	use({
		"turbio/bracey.vim",
		run = "npm install --prefix server",
		cmd = "Bracey",
	})
	-- Multicursor
	use("terryma/vim-multiple-cursors")
	-- Easy way to make commets
	use("preservim/nerdcommenter")
	-- Color picker for css
	use("KabbAmine/vCoolor.vim")
	-- Git diffs
	use("mhinz/vim-signify")
	-- Show #fffffffff with colors
	use("ap/vim-css-color")
	-- Repeat all the commands using dot key
	use("tpope/vim-repeat")

	-- AUTO COMPLETE
	-- It gives nvim a general editing configuration for identation
	use("editorconfig/editorconfig-vim")
	-- Auto complete parentesis
	use("jiangmiao/auto-pairs")
	-- It helps to 'CRUD' parentesis, comillas and tags
	use("tpope/vim-surround")
	-- Auto complete tags
	use("alvan/vim-closetag")

	-- SNIPPETS
	use("tomtom/tlib_vim")
	use("L3MON4D3/LuaSnip")
	use("garbas/vim-snipmate")
	use("MarcWeber/vim-addon-mw-utils")

	-- AUTO COMPLETE
	use({
		"hrsh7th/nvim-cmp",
		require = {
			use("hrsh7th/cmp-git"),
			use("hrsh7th/cmp-path"),
			use("hrsh7th/cmp-calc"),
			use("hrsh7th/cmp-buffer"),
			use("hrsh7th/cmp-cmdline"),
			use("hrsh7th/cmp-nvim-lsp"),
			use("hrsh7th/cmp-nvim-lua"),
			use("dmitmel/cmp-digraphs"),
			use("onsails/lspkind.nvim"),
			use("ray-x/cmp-treesitter"),
			use("hrsh7th/cmp-nvim-lua"),
			use("uga-rosa/cmp-dictionary"),
			use("saadparwaiz1/cmp_luasnip"),
			use("hrsh7th/cmp-nvim-lsp-signature-help"),
			use("hrsh7th/cmp-nvim-lsp-document-symbol"),
		},
	})
end)
