local cmd = vim.cmd
local fn = vim.fn
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
opt.smartindent = true
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
-- Persistent Undo

local undodir = fn.expand(fn.stdpath 'cache' .. '/undo')

if fn.isdirectory(undodir) == 0 then fn.mkdir(undodir, 'p') end

opt.undodir = undodir
opt.undofile = true

-- Display
opt.showmode = false
opt.relativenumber = true
opt.number = true
opt.lazyredraw = true
opt.cursorline = true

-- Allow Transparency
cmd 'hi! Normal ctermbg=NONE guibg=NONE'
cmd 'hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE'
cmd 'highlight link EndOfBuffer Comment'

opt.sidescrolloff = 3

-- Search
opt.ignorecase = true
opt.smartcase = true
