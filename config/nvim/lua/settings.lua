local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt

opt.ruler = true
opt.hidden = true
opt.showcmd = true
opt.mouse = 'a' -- Enable mouse support
opt.iskeyword:append { '-' } -- Set Hyphen as part of a text object
opt.updatetime = 100

opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will be to the right
opt.winwidth = 84
opt.winheight = 10
opt.winminheight = 10

-- Whitespace
opt.list = true -- Show invisible characters
opt.listchars = { tab = ">~", trail = '·', eol = '¬', nbsp = '_' }
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
opt.autoread = true -- When file is written to outside of vim, read again

-- Persistent Undo

local undodir = fn.expand(fn.stdpath("cache") .. "/undo")

if fn.isdirectory(undodir) == 0 then
  fn.mkdir(undodir, 'p')
end

opt.undodir = undodir
opt.undofile = true

-- Display
opt.background = 'dark'
vim.g.colors_name = 'tender'

opt.termguicolors = true -- Add 24 bit color support
opt.showmode = false
opt.relativenumber = true
opt.number = true
opt.lazyredraw = true
opt.cursorline = true

-- Allow Transparency
cmd('hi! Normal ctermbg=NONE guibg=NONE')
cmd('hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE')
cmd('highlight link EndOfBuffer Comment')

-- Sensible side scrolling 
opt.sidescroll = 1
opt.sidescrolloff = 3

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Highlight on Yank
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
