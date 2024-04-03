vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

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
