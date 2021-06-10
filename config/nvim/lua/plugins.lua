local cmd = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  cmd 'packadd packer.nvim'
end

cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Fuzzy finder
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Better syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use { 
    'kyazdani42/nvim-tree.lua', 
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() 
      require'nvim-tree.view'.View.width = 20
      vim.g.nvim_tree_auto_open = 1
      vim.g.nvim_tree_auto_close = 1
      vim.g.nvim_tree_quit_on_open = 1
      vim.g.nvim_tree_follow = 1
    end
  }


  -- LSP and completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'nvim-lua/completion-nvim'
  use 'onsails/lspkind-nvim'
  use 'simrat39/symbols-outline.nvim'
  use { 'wantyapps/nlua.nvim', branch = 'wanty' } -- Add Lua LSP. Use unmerged PR for now

  -- Snippets
  use { 'hrsh7th/vim-vsnip', requires = { "rafamadriz/friendly-snippets" } }
  use 'hrsh7th/vim-vsnip-integ'

  -- UI
  use 'jacoborus/tender.vim'

  use { 
    'Th3Whit3Wolf/onebuddy', 
    requires = {
      'tjdevries/colorbuddy.vim'
    },
    config = function()
      require('colorbuddy').colorscheme('onebuddy')
    end
  }

  use {
    'glepnir/galaxyline.nvim', -- Status line written in Lua
    branch = 'main',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
    config = function()
      require('statusline')
    end
  }

  use {
    'lewis6991/gitsigns.nvim', -- Adds Git highlighting
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Tools
  use 'ojroques/vim-oscyank' -- Copy to Clipboard using ANSI OCS52
  use { 
    'norcalli/nvim-colorizer.lua', 
    config =  function()
      require('colorizer').setup()
    end
  }
  use 'b3nj5m1n/kommentary' -- Comment mapings
  use 'kevinhwang91/nvim-bqf' -- Make QuickFix better
  use 'p00f/nvim-ts-rainbow' -- Enable multiple parentheses
  use 'rhysd/committia.vim' -- More Pleasant Editing on Commit Message
  use 'tpope/vim-unimpaired' -- Add elegant mappings
  use 'lambdalisue/suda.vim' -- Sudo support in nvim
  use 'tpope/vim-fugitive' -- Git for Vim

  use {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup({
        disable_on_zoom = true
      })
    end
  }

  use {
    "blackCauldron7/surround.nvim",
    config = function()
      require "surround".setup {}
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  use {
    'windwp/nvim-spectre',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim'
    }
  }
  end)
