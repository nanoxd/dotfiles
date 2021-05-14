local u = require('utils')
local cmd = vim.cmd
local fn = vim.fn

local function flag(key, scope)
  local s = 'o'
  if scope then s = scope end
  u.opt(s, key, true)
end

flag('ruler')
flag('hidden')
flag('showcmd')
u.opt('o', 'mouse', 'a') -- Enable mouse support

flag('splitbelow') -- Horizontal splits will automatically be below
flag('splitright') -- Vertical splits will be to the right
u.opt('o', 'winwidth', 84)
u.opt('o', 'winheight', 10)
u.opt('o', 'winminheight', 10)

-- Whitespace
u.opt('w', 'listchars', [[tab:▸\ ,trail:·,eol:¬,nbsp:_]])
flag('smartindent', 'b')
u.opt('w', 'wrap', false)

-- Spacing
u.opt('o', 'tabstop', 2)
u.opt('o', 'shiftwidth', 2)
u.opt('o', 'softtabstop', 2)
flag('expandtab')
flag('list') -- Show invisible characters

-- Turn off swap files
u.opt('o', 'backup', false)
u.opt('o', 'writebackup', false)
u.opt('o', 'swapfile', false)
flag('autoread') -- When file is written to outside of vim, read again

-- Persistent Undo

local undodir = fn.expand(fn.stdpath("cache") .. "/undo")

if fn.isdirectory(undodir) == 0 then
  fn.mkdir(undodir, 'p')
end

u.opt('o', 'undodir', undodir)
flag('undofile')

-- Display
u.opt('o', 'background', 'dark')
vim.g.colors_name = 'tender'

flag('termguicolors') -- Add 24 bit color support
u.opt('o', 'showmode', false)
flag('relativenumber')
flag('number')
flag('lazyredraw')
flag('cursorline')

-- Allow Transparency
cmd('hi! Normal ctermbg=NONE guibg=NONE')
cmd('hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE')
cmd('highlight link EndOfBuffer Comment')

-- Sensible side scrolling 
u.opt('o', 'sidescroll', 1)
u.opt('w', 'sidescrolloff', 3)

-- Search
flag('ignorecase')
flag('smartcase')

-- Highlight on Yank
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
