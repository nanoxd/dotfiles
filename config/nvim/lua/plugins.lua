local cmd = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nathom/filetype.nvim"

  -- Fuzzy finder
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim', 
    run = 'make' ,
    config = function()
      require('telescope').load_extension('fzf')
    end
  }


  -- Better syntax highlighting
  use { 
    'nvim-treesitter/nvim-treesitter', 
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
  }

  use { 
    'kyazdani42/nvim-tree.lua', 
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() 
      require'nvim-tree'.setup {
        disable_netrw = true,
        hijack_netrw = true,
        update_focused_file = {
          enable = true
        },
      }
    end
  }


  -- LSP and completion
  use 'neovim/nvim-lspconfig'
  use {
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'ray-x/cmp-treesitter',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
    }
  }

  use 'onsails/lspkind-nvim'
  use 'simrat39/symbols-outline.nvim'
  use { 'wantyapps/nlua.nvim', branch = 'wanty' } -- Add Lua LSP. Use unmerged PR for now
  use {
    'simrat39/rust-tools.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim'
    },
  }

  -- Snippets
  use { 'hrsh7th/vim-vsnip', requires = { "rafamadriz/friendly-snippets" } }
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-vsnip'

  -- UI
  use 'jacoborus/tender.vim'
  use {
    'akinsho/bufferline.nvim', 
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {}
    end
}

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
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons', opt = true
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'onedark',
          section_separators = { left = '', right = ''},
          component_separators = { left = '', right = ''}
        },
      }
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
    'chentoast/marks.nvim', -- Improve marks
    config = function()
      require('marks').setup({
        default_mappings = true,
      })
    end
  }

  use {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup({
        disable_on_zoom = true
      })
    end
  }

  use {
    "ur4ltz/surround.nvim",
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

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  }

  use {
    "AckslD/nvim-neoclip.lua",
    requires = {'tami5/sqlite.lua', module = 'sqlite'},
    config = function()
      require('neoclip').setup()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
