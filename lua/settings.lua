--==[ Settings ]==--
local set = vim.opt

-- Performance
set.lazyredraw = true
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Number line
set.sw=2
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
set.updatetime = 300
set.splitright = true
set.encoding = 'UTF-8'
set.writebackup = false
set.termguicolors = true

-- Mouse support
set.mouse = 'a'
set.title = true
set.visualbell = true
set.cursorline = false
set.clipboard = 'unnamedplus'

-- Spaces & Tabs
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
