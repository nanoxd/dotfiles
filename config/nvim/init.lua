cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
utils = require('utils')

-- Map leader to space
g.mapleader = " "

require('plugins')
require('keys')
require('statusline')
require('settings')
require('formatting')
require('ls')
require('plugin_config.compe')

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

