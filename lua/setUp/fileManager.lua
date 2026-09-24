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

	filters = {
    git_ignored = false,
		dotfiles = false,
		custom = {},
	},

	view = {
		width = 60,
		side = "right",
		adaptive_size = true,
		centralize_selection = false,
		preserve_window_proportions = false,
		relativenumber = false,
		number = false,
		signcolumn = "yes",
	},

	renderer = {
		full_name = false,
		group_empty = false,
		add_trailing = false,
		highlight_git = true,
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
		icons = {
			webdev_colors = true,
			git_placement = "before",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			-- Same Nerd Font set as greeter (   ) — not codicons (�…) that render as □.
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "",
				modified = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "➜",
					untracked = "",
					deleted = "",
					ignored = "",
				},
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
