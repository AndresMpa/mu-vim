local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.uv.fs_stat(pckr_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/lewis6991/pckr.nvim",
      pckr_path,
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require("pckr").add({

  --=========================================================
  -- LSP CORE
  --=========================================================

  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  "mfussenegger/nvim-lint",
  "mhartington/formatter.nvim",

  --=========================================================
  -- AI CORE (CORRECTO)
  --=========================================================

  {
    "olimorris/codecompanion.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  --=========================================================
  -- AUTOCOMPLETE
  --=========================================================

  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
  },

  "L3MON4D3/LuaSnip",

  --=========================================================
  -- TREESITTER
  --=========================================================

  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },

  "windwp/nvim-ts-autotag",

  --=========================================================
  -- UI CORE
  --=========================================================

  "marko-cerovac/material.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "akinsho/bufferline.nvim",
  "nvim-tree/nvim-tree.lua",
  "nvim-telescope/telescope.nvim",
  "lukas-reineke/indent-blankline.nvim",

  --=========================================================
  -- GIT
  --=========================================================

  {
    "lewis6991/gitsigns.nvim",
  },

  "tpope/vim-fugitive",

  --=========================================================
  -- COMMENTS (mantengo pero ya moderno)
  --=========================================================

  {
    "numToStr/Comment.nvim",
  },

  --=========================================================
  -- COLOR HIGHLIGHT (FIX REAL)
  --=========================================================

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "background",
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },

  --=========================================================
  -- MOTION
  --=========================================================

  "christoomey/vim-tmux-navigator",
  "easymotion/vim-easymotion",

  --=========================================================
  -- START SCREEN
  --=========================================================

  {
    "goolord/alpha-nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
  },

  --=========================================================
  -- UTILITIES
  --=========================================================

  {
    "Pocco81/auto-save.nvim",
  },

})
