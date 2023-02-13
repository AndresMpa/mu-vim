require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,

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
		relativenumber = false,
		number = false,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {},
		},
	},

	renderer = {
		full_name = false,
		group_empty = false,
		add_trailing = false,
		highlight_git = false,
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

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
