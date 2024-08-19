local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.uv.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()


require('pckr').add{
  -- DIAGNOSTICS
  "folke/lsp-colors.nvim",
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
  },

  -- Ollama
  "David-Kunz/gen.nvim",

  -- LSP
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-lint",
  "williamboman/mason.nvim",
  "mhartington/formatter.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- MODES
  "Iron-E/nvim-libmodal",

  -- START SCREEN
  {
    "goolord/alpha-nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
  },

  -- THEME
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  },

  -- Nvim
  "norcalli/nvim-colorizer.lua",
  "marko-cerovac/material.nvim",

  -- Highlight
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },

  -- NAVIGATION
  -- File explorer
  {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
  },
  -- Files opened
  "akinsho/bufferline.nvim",

  -- MOTION
  -- Navigation between windows
  "christoomey/vim-tmux-navigator",
  -- Navigation in files
  "easymotion/vim-easymotion",

  --INDENTATION & SYNTAX
  -- Indentation helper (It shows the indentation of functions, etc)
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },
  -- TypeScript syntax
  "leafgarland/typescript-vim",
  -- JS and JSX syntax
  "maxmellon/vim-jsx-pretty",
  -- JavaScript support
  "pangloss/vim-javascript",
  -- Syntax highlight for multiple languages
  "sheerun/vim-polyglot",
  -- Support to git commands
  "tpope/vim-fugitive",
  -- Indentation for bash scripts
  "z0mbix/vim-shfmt",

  -- UTILITIES
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- IMAGE PREVIEWER
  { "m00qek/baleia.nvim", tag = "v1.2.0" },
  {
    "samodostal/image.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Live server
  {
    "turbio/bracey.vim",
    run = "npm install --prefix server",
    cmd = "Bracey",
  },

  -- Multicursor
  "terryma/vim-multiple-cursors",
  -- Easy way to make comments
  "preservim/nerdcommenter",
  -- Color picker for css
  "KabbAmine/vCoolor.vim",
  -- Git diffs
  "mhinz/vim-signify",
  -- Show #fffffffff with colors
  "ap/vim-css-color",
  -- Repeat all the commands using dot key
  "tpope/vim-repeat",

  -- AUTO COMPLETE
  -- It gives nvim a general editing configuration for identation
  "editorconfig/editorconfig-vim",
  -- Auto complete parentesis
  "jiangmiao/auto-pairs",
  -- It helps to 'CRUD' parentesis, comillas and tags
  "tpope/vim-surround",
  -- Auto complete tags
  "windwp/nvim-ts-autotag",

  -- SNIPPETS
  "tomtom/tlib_vim",
  "L3MON4D3/LuaSnip",
  "garbas/vim-snipmate",
  "MarcWeber/vim-addon-mw-utils",

  -- AUTO COMPLETE
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "ray-x/cmp-treesitter",
      "uga-rosa/cmp-dictionary",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
  },

  -- AUTO SAVE
  "Pocco81/auto-save.nvim"
}
