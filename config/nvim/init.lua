cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
utils = require('utils')

-- Map leader to space
g.mapleader = " "
vim.g.termguicolors = true -- Add 24 bit color support
vim.g.did_load_filetypes = 1

require('plugins')
require('keys')
require('statusline')
require('settings')
require('formatting')
require('ls')
require('plugin_config.cmp')

local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained', 
  highlight = {enable = true},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000
  }
}

