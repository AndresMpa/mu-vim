--==[ Treesitter ]==--

-- Modules
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
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
}
