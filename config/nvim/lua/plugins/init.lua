return {
  "nathom/filetype.nvim",

  -- Better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  -- LSP and completion
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end,
  },
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
    },
  },

  "onsails/lspkind.nvim",
  "simrat39/symbols-outline.nvim",

  -- Snippets
  { "hrsh7th/vim-vsnip", dependencies = { "rafamadriz/friendly-snippets" } },
  "hrsh7th/vim-vsnip-integ",
  "hrsh7th/cmp-vsnip",

  -- UI
  "jacoborus/tender.vim",
  {
    "akinsho/bufferline.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({})
    end,
  },

  {
    "Th3Whit3Wolf/onebuddy",
    dependencies = {
      "tjdevries/colorbuddy.vim",
    },
    config = function()
      require("colorbuddy").colorscheme("onebuddy")
    end,
  },

  {
    "lewis6991/gitsigns.nvim", -- Adds Git highlighting
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Tools
  "ojroques/nvim-osc52", -- Copy to Clipboard using ANSI OCS52
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  "b3nj5m1n/kommentary", -- Comment mapings
  "kevinhwang91/nvim-bqf", -- Make QuickFix better
  "p00f/nvim-ts-rainbow", -- Enable multiple parentheses
  "rhysd/committia.vim", -- More Pleasant Editing on Commit Message
  "tpope/vim-unimpaired", -- Add elegant mappings
  "lambdalisue/suda.vim", -- Sudo support in nvim
  "tpope/vim-fugitive", -- Git for Vim
  {
    "chentoast/marks.nvim", -- Improve marks
    config = function()
      require("marks").setup({
        default_mappings = true,
      })
    end,
  },

  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup({
        disable_on_zoom = true,
      })
    end,
  },

  {
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup({})
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "windwp/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "tami5/sqlite.lua", module = "sqlite" },
    config = function()
      require("neoclip").setup()
    end,
  },

  "mrjones2014/smart-splits.nvim",
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          -- Conform will run the first available formatter
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
