local ok, treesitter =
  pcall(require, "nvim-treesitter.configs")

if not ok then
  return
end

treesitter.setup({

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },

  autotag = {
    enable = true,
  },

  indent = {
    enable = false,
    disable = {},
  },

  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "haskell",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "php",
    "python",
    "rust",
    "typescript",
    "vim",
    "yaml",
  },

  ignore_install = {},
})
