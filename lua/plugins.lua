local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"
  local fs = vim.uv or vim.loop

  if not fs.fs_stat(pckr_path) then
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

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "mfussenegger/nvim-lint",
  "mhartington/formatter.nvim",

  -- Completion
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

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },
  "windwp/nvim-ts-autotag",

  -- UI
  {
    "nvim-tree/nvim-tree.lua",
    requires = "nvim-tree/nvim-web-devicons",
  },
  "akinsho/bufferline.nvim",
  "nvim-lualine/lualine.nvim",
  {
    "goolord/alpha-nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
  },
  "nvim-telescope/telescope.nvim",
  "lukas-reineke/indent-blankline.nvim",

  -- Motion
  "christoomey/vim-tmux-navigator",
  "easymotion/vim-easymotion",

  -- Git
  "tpope/vim-fugitive",
  "mhinz/vim-signify",
  {
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  },

  -- Syntax / edit
  "sheerun/vim-polyglot",
  "preservim/nerdcommenter",
  "terryma/vim-multiple-cursors",
  "jiangmiao/auto-pairs",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "editorconfig/editorconfig-vim",
  "ap/vim-css-color",
  "KabbAmine/vCoolor.vim",

  -- Preview / live
  {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "turbio/bracey.vim",
    run = "pnpm install --prefix server",
    cmd = "Bracey",
  },

  -- Utilities
  {
    "Pocco81/auto-save.nvim",
  },

})

-- First launch: mason is missing until plugins are cloned.
-- Call pckr.sync() in Lua; :Pckr is not always registered yet on VimEnter.
if not pcall(require, "mason") then
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      vim.notify(
        "Installing plugins. Quit Neovim when it finishes, then open it again.",
        vim.log.levels.INFO
      )
      local ok, pckr = pcall(require, "pckr")
      if ok and type(pckr.sync) == "function" then
        pckr.sync()
      end
    end,
  })
end
