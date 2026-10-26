local map = vim.keymap.set

-- make `-` and `_` work like `o` and `O` without leaving you stuck in insert
map('n', '-', 'o<esc>', { desc = 'Insert line below' })
map('n', '_', 'O<esc>', { desc = 'Insert line above' })

-- Expand %% into the directory of the current file
vim.cmd [[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']]
-- Save with sudo
vim.cmd [[cnoreabbrev <expr> w!! getcmdtype() == ':' && getcmdline() == 'w!!' ? 'SudaWrite' : 'w!!']]

map('n', 'gV', '`[v`]', { desc = 'Highlight last inserted text' })
map('n', 'vv', '<C-w>v', { desc = 'Vertical split', silent = true })
map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', 'J', 'mjJ`j', { desc = 'Join lines without moving cursor' })

-- Smart `0`
-- `0` goes to the beginning of the text on first press and to the beginning
-- of the line on second press. It alternates afterwards.
map('n', '0', "virtcol('.') - 1 <= indent('.') && col('.') > 1 ? '0' : '_'", { expr = true, desc = 'Smart line start' })

map('n', '<leader>u', '<cmd>Undotree<cr>', { desc = 'Undo tree' })
map('n', '<leader>fm', '<cmd>FzfLua marks<cr>', { desc = 'Marks' })

-- Move between Neovim windows, then hand off to tmux at the edge (see is_vim in tmux.conf).
local tmux_directions = { h = 'L', j = 'D', k = 'U', l = 'R' }
local function navigate(direction)
  local window = vim.api.nvim_get_current_win()
  vim.cmd.wincmd(direction)
  if vim.api.nvim_get_current_win() ~= window or not vim.env.TMUX then return end
  -- Leave a zoomed tmux pane alone, as Navigator.nvim's disable_on_zoom did.
  local zoomed = vim.system({ 'tmux', 'display-message', '-p', '#{window_zoomed_flag}' }, { text = true }):wait()
  if vim.trim(zoomed.stdout or '') == '1' then return end
  vim.system { 'tmux', 'select-pane', '-' .. tmux_directions[direction] }
end
map('n', '<C-h>', function() navigate 'h' end, { desc = 'Move left', silent = true })
map('n', '<C-j>', function() navigate 'j' end, { desc = 'Move down', silent = true })
map('n', '<C-k>', function() navigate 'k' end, { desc = 'Move up', silent = true })
map('n', '<C-l>', function() navigate 'l' end, { desc = 'Move right', silent = true })

-- Grow and shrink a selection by syntax node with the built-in `an` / `in`.
-- Normal-mode <CR> stays untouched in special buffers such as quickfix.
map(
  'n',
  '<CR>',
  function() return vim.bo.buftype == '' and 'van' or '<CR>' end,
  { expr = true, remap = true, desc = 'Select node' }
)
map('x', '<CR>', 'an', { remap = true, desc = 'Expand selection to parent node' })
map('x', '<BS>', 'in', { remap = true, desc = 'Shrink selection to child node' })

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserRustKeys', { clear = true }),
  pattern = 'rust',
  callback = function(event)
    map('n', '<leader>r', '<cmd>RustLsp runnables<cr>', { buffer = event.buf, desc = 'Rust runnables', silent = true })
  end,
})

-- Native diagnostics / quickfix
map('n', '<leader>xw', function() vim.diagnostic.setqflist { open = true } end, { desc = 'Workspace diagnostics' })
map('n', '<leader>xd', function()
  vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(0)), 'r')
  vim.cmd.copen()
end, { desc = 'Document diagnostics' })
map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Open quickfix list' })
map(
  'n',
  '<leader>xl',
  function() vim.diagnostic.setloclist { open = true } end,
  { desc = 'Document diagnostics loclist' }
)

-- Git
map('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = 'Git blame', silent = true })
