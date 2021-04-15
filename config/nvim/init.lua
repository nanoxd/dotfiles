local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local o = vim.o

-- Map leader to space
g.mapleader = " "

require('plugins')
require('keys')
require('statusline')

o.background = 'dark'
g.colors_name = 'tender'
