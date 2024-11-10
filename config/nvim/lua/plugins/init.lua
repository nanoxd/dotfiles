return {
  'nathom/filetype.nvim',

  -- LSP and completion
  'simrat39/symbols-outline.nvim',

  -- UI
  'jacoborus/tender.vim',
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('bufferline').setup {} end,
  },

  {
    'Th3Whit3Wolf/onebuddy',
    dependencies = {
      'tjdevries/colorbuddy.vim',
    },
    config = function() require('colorbuddy').colorscheme 'onebuddy' end,
  },

  {
    'lewis6991/gitsigns.nvim', -- Adds Git highlighting
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function() require('gitsigns').setup() end,
  },

  -- Tools
  'ojroques/nvim-osc52', -- Copy to Clipboard using ANSI OCS52
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },
  'kevinhwang91/nvim-bqf', -- Make QuickFix better
  'p00f/nvim-ts-rainbow', -- Enable multiple parentheses
  'rhysd/committia.vim', -- More Pleasant Editing on Commit Message
  'tpope/vim-unimpaired', -- Add elegant mappings
  'lambdalisue/suda.vim', -- Sudo support in nvim
  'tpope/vim-fugitive', -- Git for Vim
  {
    'chentoast/marks.nvim', -- Improve marks
    config = function()
      require('marks').setup {
        default_mappings = true,
      }
    end,
  },

  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup {
        disable_on_zoom = true,
      }
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'windwp/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
  },

  {
    'AckslD/nvim-neoclip.lua',
    dependencies = { 'tami5/sqlite.lua', module = 'sqlite' },
    config = function() require('neoclip').setup() end,
  },

  'mrjones2014/smart-splits.nvim',
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Conform will run multiple formatters sequentially
          python = { 'isort', 'black' },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { 'rustfmt', lsp_format = 'fallback' },
          -- Conform will run the first available formatter
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
      }
    end,
  },
}
