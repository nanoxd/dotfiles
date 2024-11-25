cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
g = vim.g -- a table to access global variables
utils = require 'utils'

-- Map leader to space
g.mapleader = ' '
vim.opt.termguicolors = true -- Add 24 bit color support
vim.opt.signcolumn = 'yes'
g.did_load_filetypes = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

require 'config.lazy'
require 'keys'
require 'settings'
require 'formatting'
require 'ls'
require 'plugin_config.cmp'
