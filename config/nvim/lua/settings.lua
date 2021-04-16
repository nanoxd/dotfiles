local u = require('utils')

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

u.opt('o', 'background', 'dark')
vim.g.colors_name = 'tender'

-- Whitespace
u.opt('w', 'listchars', [[tab:▸\ ,trail:·,eol:¬,nbsp:_]])
flag('smartindent', 'b')
u.opt('w', 'wrap', false)

