local apply = require("scheme.apply")

local picker = {
	win = nil,
	buf = nil,
	saved = nil,
	preview = nil,
	closing = false,
	old_move = nil,
}

local function restyle()
	if picker.win and vim.api.nvim_win_is_valid(picker.win) then
		vim.wo[picker.win].winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder"
		vim.wo[picker.win].cursorline = true
	end
end

local function line_name()
	local line = vim.api.nvim_get_current_line()
	return (line:gsub("^[ *]*", ""))
end

local function preview()
	if picker.closing then
		return
	end
	local name = line_name()
	if name == "" or name == picker.preview then
		return
	end
	picker.preview = name
	apply.load(name)
	restyle()
end

local function mouse_preview()
	if picker.closing or not picker.win then
		return
	end
	local ok, m = pcall(vim.fn.getmousepos)
	if not ok or m.winid ~= picker.win or m.line < 1 then
		return
	end
	if vim.api.nvim_win_get_cursor(picker.win)[1] ~= m.line then
		pcall(vim.api.nvim_win_set_cursor, picker.win, { m.line, 0 })
	end
	preview()
end

local function finish(save)
	if picker.closing then
		return
	end
	picker.closing = true
	local name = picker.preview
	local saved = picker.saved
	if picker.old_move ~= nil then
		vim.o.mousemoveevent = picker.old_move
	end
	local win = picker.win
	picker.win, picker.buf, picker.preview, picker.saved, picker.old_move = nil, nil, nil, nil, nil
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, true)
	end
	if save and name and name ~= "" then
		apply.persist(name)
		print("MμVim theme: " .. name)
	else
		apply.load(saved or apply.default_name())
	end
	picker.closing = false
end

local M = {}

function M.open()
	local names = apply.names()
	if #names == 0 then
		print("No MμVim themes")
		return
	end
	if picker.win and vim.api.nvim_win_is_valid(picker.win) then
		return
	end
	picker.saved = apply.saved_name()
	picker.preview = nil
	picker.closing = false

	local lines = {}
	local start = 1
	for i, n in ipairs(names) do
		if n == picker.saved then
			lines[i] = "* " .. n
			start = i
		else
			lines[i] = "  " .. n
		end
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "muvim-themes"

	local width = 28
	for _, n in ipairs(names) do
		width = math.max(width, vim.fn.strdisplaywidth(n) + 4)
	end
	width = math.min(width, math.max(20, vim.o.columns - 4))
	local height = math.min(#lines, math.max(8, math.floor(vim.o.lines / 2)))
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = math.max(0, math.floor((vim.o.lines - height) / 2)),
		col = math.max(0, math.floor((vim.o.columns - width) / 2)),
		style = "minimal",
		border = "rounded",
		title = " Themes ",
		title_pos = "center",
	}
	local ok, win = pcall(vim.api.nvim_open_win, buf, true, opts)
	if not ok then
		opts.title, opts.title_pos = nil, nil
		win = vim.api.nvim_open_win(buf, true, opts)
	end
	picker.buf = buf
	picker.win = win
	vim.api.nvim_win_set_cursor(win, { start, 0 })
	vim.wo[win].cursorline = true
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
	vim.wo[win].wrap = false

	local map = function(lhs, fn)
		vim.keymap.set("n", lhs, fn, { buffer = buf, silent = true, nowait = true })
	end
	map("<CR>", function()
		preview()
		finish(true)
	end)
	map("<Esc>", function()
		finish(false)
	end)
	map("q", function()
		finish(false)
	end)
	map("<C-c>", function()
		finish(false)
	end)

	local au = vim.api.nvim_create_augroup("MuvimThemePicker", { clear = true })
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = au,
		buffer = buf,
		callback = preview,
	})
	pcall(function()
		picker.old_move = vim.o.mousemoveevent
		vim.o.mousemoveevent = true
		vim.api.nvim_create_autocmd("MouseMove", {
			group = au,
			callback = mouse_preview,
		})
	end)
	restyle()
	preview()
end

return M
