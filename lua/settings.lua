local set = vim.opt

-- Performance
set.lazyredraw = true

-- Number line
set.sw = 2
set.number = true
set.relativenumber = true

-- Interface style
set.ruler = true
set.hidden = true
set.cmdheight = 1
set.showcmd = true
set.backup = false
set.showmode = false
set.showmatch = true
set.swapfile = false
set.splitright = true
set.encoding = "UTF-8"
set.writebackup = false
set.termguicolors = true

-- Spelling
set.spell = true
set.spelllang = { "en_us" }

-- Mouse support
set.mouse = "a"
set.title = true
set.visualbell = true
set.cursorline = false
set.clipboard = "unnamedplus"

-- Autos
set.autoindent = true
set.updatetime = 300
set.autowrite = true

-- Spaces & Tabs
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Prefixes
set.completeopt = { "menu", "menuone", "noselect" }
set.errorformat:append("%f|%l col %c|%m")
set.listchars:append("space:⋅")
set.listchars:append("eol:↴")
set.list = true

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
