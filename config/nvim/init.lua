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
require('plugin_config')

