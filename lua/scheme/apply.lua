local M = {}

local user_dir = vim.fn.expand("~/.config/muvim")
local user_themes = user_dir .. "/themes"
local active_file = user_dir .. "/active"
local sourced = debug.getinfo(1, "S").source
if sourced:sub(1, 1) == "@" then
	sourced = sourced:sub(2)
end
local shipped = vim.fn.fnamemodify(sourced, ":h") .. "/palettes"

local function default_name()
	return vim.g.muvim_default_theme or "deep-ocean"
end

local function hi(group, fg, bg, style)
	local opts = {}
	if fg and fg ~= "" then
		opts.fg = fg
	end
	if bg and bg ~= "" then
		opts.bg = bg
	end
	if style == "bold" then
		opts.bold = true
	elseif style == "italic" then
		opts.italic = true
	elseif style == "underline" then
		opts.underline = true
	elseif style == "undercurl" then
		opts.undercurl = true
	end
	vim.api.nvim_set_hl(0, group, opts)
end

local function parse_vim_palette(text)
	local pal = {}
	for key, hex in text:gmatch("'([%w_]+)'%s*:%s*'(#[A-Fa-f0-9]+)'") do
		pal[key] = hex
	end
	return pal.bg and pal or nil
end

local function load_lua_file(path)
	local chunk, err = loadfile(path)
	if not chunk then
		return nil, err
	end
	local ok, pal = pcall(chunk)
	if ok and type(pal) == "table" and pal.bg then
		return pal
	end
	return nil
end

local function palette_for(name)
	local lua_user = user_themes .. "/" .. name .. ".lua"
	local vim_user = user_themes .. "/" .. name .. ".vim"
	local lua_ship = shipped .. "/" .. name .. ".lua"
	if vim.fn.filereadable(lua_user) == 1 then
		return load_lua_file(lua_user)
	end
	if vim.fn.filereadable(vim_user) == 1 then
		local f = io.open(vim_user, "r")
		if f then
			local text = f:read("*a")
			f:close()
			return parse_vim_palette(text)
		end
	end
	if vim.fn.filereadable(lua_ship) == 1 then
		return load_lua_file(lua_ship)
	end
	return nil
end

function M.names()
	local seen = {}
	local list = {}
	local function add_from(dir, ext)
		for _, path in ipairs(vim.fn.glob(dir .. "/*." .. ext, false, true)) do
			local n = vim.fn.fnamemodify(path, ":t:r")
			if n ~= "apply" and not seen[n] then
				seen[n] = true
				table.insert(list, n)
			end
		end
	end
	add_from(shipped, "lua")
	add_from(user_themes, "lua")
	add_from(user_themes, "vim")
	table.sort(list)
	return list
end

local ICON_EXT = {
	js = "yellow",
	mjs = "yellow",
	cjs = "yellow",
	jsx = "cyan",
	javascript = "yellow",
	ts = "blue",
	tsx = "blue",
	typescript = "blue",
	vue = "green",
	svelte = "orange",
	html = "orange",
	htm = "orange",
	css = "purple",
	scss = "purple",
	sass = "purple",
	less = "purple",
	json = "yellow",
	jsonc = "yellow",
	lua = "blue",
	vim = "green",
	py = "yellow",
	python = "yellow",
	rb = "red",
	ruby = "red",
	go = "cyan",
	rs = "orange",
	rust = "orange",
	c = "blue",
	h = "blue",
	cpp = "blue",
	hpp = "blue",
	java = "orange",
	kt = "purple",
	md = "fg",
	markdown = "fg",
	yml = "red",
	yaml = "red",
	toml = "orange",
	xml = "orange",
	sh = "green",
	bash = "green",
	zsh = "green",
	fish = "green",
	git = "red",
	gitignore = "red",
	gitattributes = "red",
	dockerfile = "cyan",
	docker = "cyan",
	lock = "dim",
	svg = "accent",
	png = "purple",
	jpg = "purple",
	jpeg = "purple",
	gif = "purple",
	webp = "purple",
	txt = "fg",
	default = "fg",
}

local function paint_icons(p)
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return
	end
	local wheel = { p.red, p.orange, p.yellow, p.green, p.cyan, p.blue, p.purple, p.accent }
	local function color_for(key)
		local k = string.lower(key or "")
		local slot = ICON_EXT[k]
		if slot and p[slot] then
			return p[slot]
		end
		local sum = 0
		for i = 1, #k do
			sum = sum + k:byte(i)
		end
		return wheel[(sum % #wheel) + 1]
	end
	local icons = devicons.get_icons()
	if not icons then
		return
	end
	local overrides = {}
	for key, spec in pairs(icons) do
		if type(spec) == "table" then
			overrides[key] = {
				icon = spec.icon,
				color = color_for(key),
				cterm_color = spec.cterm_color,
				name = spec.name,
			}
		end
	end
	devicons.set_icon(overrides)
	pcall(devicons.set_up_highlights)
	if package.loaded["setUp.buffer"] then
		package.loaded["setUp.buffer"] = nil
		pcall(require, "setUp.buffer")
	end
end

local function refresh_lualine()
	if package.loaded["setUp.statusLine"] then
		package.loaded["setUp.statusLine"] = nil
		pcall(require, "setUp.statusLine")
	end
end

local function paint(p)
	vim.o.termguicolors = true
	vim.o.background = "dark"
	pcall(vim.cmd, "highlight clear")
	pcall(vim.cmd, "syntax reset")

	local bg, bg_alt, fg = p.bg, p.bg_alt, p.fg
	local dim, red, orange, yellow = p.dim, p.red, p.orange, p.yellow
	local green, cyan, blue, purple, accent = p.green, p.cyan, p.blue, p.purple, p.accent

	hi("Normal", fg, bg)
	hi("NormalNC", fg, bg)
	hi("NormalFloat", fg, bg_alt)
	hi("FloatBorder", dim, bg_alt)
	hi("Comment", dim, nil, "italic")
	hi("Constant", orange)
	hi("String", green)
	hi("Character", green)
	hi("Number", orange)
	hi("Boolean", orange)
	hi("Float", orange)
	hi("Identifier", cyan)
	hi("Function", blue, nil, "bold")
	hi("Statement", purple)
	hi("Conditional", purple)
	hi("Repeat", purple)
	hi("Label", yellow)
	hi("Operator", cyan)
	hi("Keyword", purple)
	hi("Exception", red)
	hi("PreProc", cyan)
	hi("Include", cyan)
	hi("Define", purple)
	hi("Macro", purple)
	hi("Type", yellow)
	hi("StorageClass", yellow)
	hi("Structure", yellow)
	hi("Special", accent)
	hi("SpecialChar", orange)
	hi("Tag", red)
	hi("Delimiter", fg)
	hi("Underlined", blue, nil, "underline")
	hi("Ignore", dim)
	hi("Error", red, nil, "bold")
	hi("Todo", yellow, nil, "bold")
	hi("ColorColumn", nil, bg_alt)
	hi("CursorLine", nil, bg_alt)
	hi("CursorLineNr", accent, bg_alt, "bold")
	hi("LineNr", dim, bg)
	hi("SignColumn", fg, bg)
	hi("Folded", dim, bg_alt, "italic")
	hi("FoldColumn", dim, bg)
	hi("MatchParen", accent, bg_alt, "bold")
	hi("Search", bg, yellow)
	hi("IncSearch", bg, orange)
	hi("CurSearch", bg, orange)
	hi("Visual", nil, bg_alt)
	hi("NonText", dim)
	hi("EndOfBuffer", bg, bg)
	hi("Whitespace", dim)
	hi("SpecialKey", dim)
	hi("Directory", blue, nil, "bold")
	hi("Title", blue, nil, "bold")
	hi("Question", green)
	hi("MoreMsg", green)
	hi("ModeMsg", fg, nil, "bold")
	hi("WarningMsg", yellow)
	hi("ErrorMsg", red, nil, "bold")
	hi("WildMenu", bg, blue)
	hi("Pmenu", fg, bg_alt)
	hi("PmenuSel", bg, blue)
	hi("PmenuSbar", nil, bg_alt)
	hi("PmenuThumb", nil, dim)
	hi("StatusLine", fg, bg_alt)
	hi("StatusLineNC", dim, bg_alt)
	hi("WinSeparator", dim, bg)
	hi("VertSplit", dim, bg)
	hi("TabLine", dim, bg_alt)
	hi("TabLineFill", dim, bg)
	hi("TabLineSel", fg, bg, "bold")
	hi("QuickFixLine", nil, bg_alt)
	hi("SpellBad", red, nil, "undercurl")
	hi("SpellCap", yellow, nil, "undercurl")
	hi("SpellRare", purple, nil, "undercurl")
	hi("SpellLocal", cyan, nil, "undercurl")
	hi("DiffAdd", green, bg_alt)
	hi("DiffChange", yellow, bg_alt)
	hi("DiffDelete", red, bg_alt)
	hi("DiffText", blue, bg_alt, "bold")
	hi("DiagnosticError", red)
	hi("DiagnosticWarn", yellow)
	hi("DiagnosticInfo", blue)
	hi("DiagnosticHint", cyan)
	hi("GitSignsAdd", green)
	hi("GitSignsChange", yellow)
	hi("GitSignsDelete", red)
	hi("TelescopeBorder", dim, bg)
	hi("TelescopeSelection", fg, bg_alt)
	hi("NvimTreeNormal", fg, bg)
	hi("NvimTreeFolderName", blue)
	hi("NvimTreeOpenedFolderName", blue, nil, "bold")
	hi("NvimTreeEmptyFolderName", dim)
	hi("NvimTreeFolderIcon", blue)
	hi("NvimTreeIndentMarker", dim)
	hi("NvimTreeSymlink", cyan)
	hi("NvimTreeExecFile", green)
	hi("NvimTreeImageFile", purple)
	hi("NvimTreeGitDirty", yellow)
	hi("NvimTreeGitNew", green)
	hi("NvimTreeGitDeleted", red)
	hi("AlphaHeader", blue)
	hi("AlphaButtons", fg)
	hi("AlphaShortcut", orange)
	-- indent-blankline ColorScheme hook requires these groups after highlight clear
	local ibl = { red, yellow, green, cyan, blue, purple }
	for i, color in ipairs(ibl) do
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent" .. i, { fg = color, nocombine = true })
	end
	hi("IblIndent", dim)
	hi("IblScope", accent)

	vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@string", { link = "String" })
	vim.api.nvim_set_hl(0, "@function", { link = "Function" })
	vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
	vim.api.nvim_set_hl(0, "@type", { link = "Type" })
	vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
	vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@property", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@punctuation", { link = "Delimiter" })

	vim.g.terminal_color_0 = bg
	vim.g.terminal_color_1 = red
	vim.g.terminal_color_2 = green
	vim.g.terminal_color_3 = yellow
	vim.g.terminal_color_4 = blue
	vim.g.terminal_color_5 = purple
	vim.g.terminal_color_6 = cyan
	vim.g.terminal_color_7 = fg
	vim.g.terminal_color_8 = dim
	vim.g.terminal_color_9 = red
	vim.g.terminal_color_10 = green
	vim.g.terminal_color_11 = yellow
	vim.g.terminal_color_12 = blue
	vim.g.terminal_color_13 = purple
	vim.g.terminal_color_14 = accent
	vim.g.terminal_color_15 = fg

	paint_icons(p)
	refresh_lualine()
end

function M.load(name)
	local pal = palette_for(name)
	if not pal then
		return false
	end
	vim.g.muvim_palette = pal
	paint(pal)
	vim.g.colors_name = name
	pcall(vim.api.nvim_exec_autocmds, "ColorScheme", { modeline = false, pattern = name })
	return true
end

function M.persist(name)
	local dir = vim.fn.fnamemodify(active_file, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
	if vim.fn.isdirectory(user_themes) == 0 then
		vim.fn.mkdir(user_themes, "p")
	end
	if not name or name == "" then
		if vim.fn.filereadable(active_file) == 1 then
			vim.fn.delete(active_file)
		end
		return true
	end
	local ok = vim.fn.writefile({ name }, active_file)
	if ok ~= 0 then
		local f = io.open(active_file, "w")
		if f then
			f:write(name .. "\n")
			f:close()
			ok = 0
		end
	end
	if ok ~= 0 then
		vim.notify("Could not save theme to " .. active_file, vim.log.levels.ERROR)
		return false
	end
	return true
end

function M.saved_name()
	if vim.fn.filereadable(active_file) == 1 then
		local lines = vim.fn.readfile(active_file, "", 1)
		if lines[1] and lines[1]:match("%S") then
			return vim.trim(lines[1])
		end
	end
	return default_name()
end

function M.apply(name, opts)
	opts = opts or {}
	if name == "none" then
		name = default_name()
		if M.load(name) then
			M.persist("")
			if not opts.quiet then
				print("MμVim theme: " .. name .. " (default)")
			end
			return true
		end
		return false
	end
	if not M.load(name) then
		if not opts.quiet then
			vim.notify("Unknown MμVim theme: " .. name, vim.log.levels.ERROR)
		end
		return false
	end
	if opts.persist ~= false then
		M.persist(name)
	end
	if not opts.quiet then
		print("MμVim theme: " .. name)
	end
	return true
end

function M.restore()
	if vim.fn.filereadable(active_file) == 1 then
		local lines = vim.fn.readfile(active_file, "", 1)
		if lines[1] then
			local name = vim.trim(lines[1])
			if name ~= "" and M.load(name) then
				return
			end
		end
	end
	M.load(default_name())
end

function M.default_name()
	return default_name()
end

return M
