require("material").setup({
	contrast = {
		non_current_windows = false, -- Enable darker background for non-current windows
		floating_windows = false, -- Enable contrast for floating windows
		line_numbers = true, -- Enable contrast background for line numbers
		sign_column = false, -- Enable contrast background for the sign column
		cursor_line = false, -- Enable darker background for the cursor line
		popup_menu = false, -- Enable lighter background for the popup menu
		sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
	},

	styles = {
		comments = {
			italic = true
	  },
	  strings = {
			bold = true,
		  italic = true
		},
	  keywords = {
		  underline = false
	  },
	  functions = {
		  bold = true,
		  undercurl = false,
		},
	  variables = {
		  bold = true
		},
		operators = {
		  bold = false
		},
		types = {}
	},

	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
		"qf", -- Darker qf list background
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false, -- Enable higher contrast text for darker style
	},

	disable = {
		borders = false, -- Disable borders between verticaly split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false, -- Hide the end-of-buffer lines
	},

	custom_highlights = {}, -- Overwrite highlights with your own
})

vim.g.material_style = "deep ocean"
vim.cmd([[colorscheme material]])

-- Styles:
-- darker
-- lighter
-- oceanic
-- palenight
-- deep ocean
