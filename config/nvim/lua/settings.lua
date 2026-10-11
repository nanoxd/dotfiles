local cmd = vim.cmd
local opt = vim.opt

opt.iskeyword:append { '-' } -- Set Hyphen as part of a text object
opt.updatetime = 100

opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will be to the right
opt.winwidth = 84
opt.winheight = 10
opt.winminheight = 10

-- Whitespace
opt.list = true -- Show invisible characters
opt.listchars = { tab = '>~', trail = '·', eol = '¬', nbsp = '_' }
opt.wrap = false

-- Spacing
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- Turn off swap files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- Persistent undo, stored in the default stdpath('state')/undo
opt.undofile = true

-- Display
opt.showmode = false
opt.relativenumber = true
opt.number = true
opt.lazyredraw = true
opt.cursorline = true
opt.signcolumn = 'yes'

-- Folding: Treesitter or LSP sets foldexpr per buffer; start with everything open.
opt.foldmethod = 'expr'
opt.foldlevelstart = 99
opt.foldtext = ''

opt.sidescrolloff = 3
opt.pumborder = 'rounded'
opt.winborder = 'rounded' -- Default border for hover, signature help, and other floats

-- Experimental 0.12 message and cmdline UI: highlighted cmdline, no hit-enter prompts.
require('vim._core.ui2').enable()

-- Built-in :Undotree
cmd.packadd 'nvim.undotree'

-- Search
opt.ignorecase = true
opt.smartcase = true
