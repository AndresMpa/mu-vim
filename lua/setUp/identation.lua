local highlight = {
	"IndentBlanklineIndent1",
	"IndentBlanklineIndent2",
	"IndentBlanklineIndent3",
	"IndentBlanklineIndent4",
	"IndentBlanklineIndent5",
	"IndentBlanklineIndent6",
}
local scope_highlight = {
	"IndentBlanklineScope1",
	"IndentBlanklineScope2",
	"IndentBlanklineScope3",
	"IndentBlanklineScope4",
	"IndentBlanklineScope5",
	"IndentBlanklineScope6",
}

local function ibl_highlights()
	local p = vim.g.muvim_palette or {}
	local colors = {
		p.red or "#E06C75",
		p.yellow or "#E5C07B",
		p.green or "#98C379",
		p.cyan or "#56B6C2",
		p.blue or "#61AFEF",
		p.purple or "#C678DD",
	}
	for i, color in ipairs(colors) do
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent" .. i, { fg = color, nocombine = true })
		-- Current block: same hue as that |, but bold so it lights up.
		vim.api.nvim_set_hl(0, "IndentBlanklineScope" .. i, { fg = color, bold = true, nocombine = true })
	end
end

ibl_highlights()

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, ibl_highlights)

require("ibl").setup({
	scope = {
		char = "▏",
		enabled = true,
		show_end = true,
		show_start = true,
		show_exact_scope = true,
		injected_languages = true,
		highlight = scope_highlight,
	},
	indent = {
		char = "▏",
		smart_indent_cap = true,
		highlight = highlight,
	},
	exclude = {
		filetypes = {
			"git",
			"man",
			"help",
			"text",
			"packer",
			"lspinfo",
			"markdown",
			"terminal",
			"gitcommit",
			"checkhealth",
		},
		buftypes = {
			"nofile",
			"terminal",
		},
	},
})
