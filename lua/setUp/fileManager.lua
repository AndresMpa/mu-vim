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
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
	},
})
