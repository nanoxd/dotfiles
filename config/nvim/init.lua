cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
utils = require('utils')

-- Map leader to space
g.mapleader = " "
g.termguicolors = true -- Add 24 bit color support
g.did_load_filetypes = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

require('plugins')
require('keys')
require('settings')
require('formatting')
require('ls')
require('plugin_config.cmp')

local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = {'lua', 'rust', 'swift', 'c', 'javascript'},
  highlight = {enable = true},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        --[[ ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
        }, ]]
      },
    },
  },
}

