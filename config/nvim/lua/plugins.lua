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

  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- LSP and completion
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'onsails/lspkind-nvim'

  -- UI
  use 'jacoborus/tender.vim'
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

  -- Tools
  use 'ojroques/vim-oscyank' -- Copy to Clipboard using ANSI OCS52
  use { 'norcalli/nvim-colorizer.lua' }
end)
