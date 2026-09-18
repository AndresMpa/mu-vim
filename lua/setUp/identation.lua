local p = vim.g.muvim_palette or {}
local ibl_colors = {
	p.red or "#E06C75",
	p.yellow or "#E5C07B",
	p.green or "#98C379",
	p.cyan or "#56B6C2",
	p.blue or "#61AFEF",
	p.purple or "#C678DD",
}
for i, color in ipairs(ibl_colors) do
	vim.api.nvim_set_hl(0, "IndentBlanklineIndent" .. i, { fg = color, nocombine = true })
end

require("ibl").setup({
  scope = {
    char = "_",
    enabled = true,
    show_end = true,
    show_start = true,
    show_exact_scope = true,
    injected_languages = true,
    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
  },
  indent = {
    char = "▏",
    smart_indent_cap = true,
    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
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
