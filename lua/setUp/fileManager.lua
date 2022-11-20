require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	ignore_ft_on_setup = {},

	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			error = "",
			warning = "",
		},
	},

	update_focused_file = {
		update_cwd = false,
		enable = true,
		ignore_list = {},
	},

	system_open = {
		cmd = nil,
		args = {},
	},

	filters = {
		dotfiles = false,
		custom = {},
	},

  view = {
    width = 30,
    side = "left",
    adaptive_size = true,
    hide_root_folder = false,
    centralize_selection = false,
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {},
    },
  },

  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
  },
})
