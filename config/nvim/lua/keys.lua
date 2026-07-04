local map = vim.keymap.set

-- make `-` and `_` work like `o` and `O` without leaving you stuck in insert
map('n', '-', 'o<esc>', { desc = 'Insert line below' })
map('n', '_', 'O<esc>', { desc = 'Insert line above' })

-- Expand %% into the directory of the current file
vim.cmd [[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']]
-- Save with sudo
vim.cmd [[cmap w!! %!sudo tee > /dev/null %]]

map('n', 'gV', '`[v`]', { desc = 'Highlight last inserted text' })
map('n', 'vv', '<C-w>v', { desc = 'Vertical split', silent = true })
map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', 'J', 'mjJ`j', { desc = 'Join lines without moving cursor' })

-- Smart `0`
-- `0` goes to the beginning of the text on first press and to the beginning
-- of the line on second press. It alternates afterwards.
map('n', '0', "virtcol('.') - 1 <= indent('.') && col('.') > 1 ? '0' : '_'", { expr = true, desc = 'Smart line start' })

map('n', '<leader>e', '<cmd>Explore<cr>', { desc = 'Explore files' })
map('n', '<leader>p', '<cmd>lua require("telescope").extensions.neoclip.default()<cr>', { desc = 'Clipboard history' })

-- Navigator Bindings
map('n', '<C-h>', function() require('Navigator').left() end, { desc = 'Move left', silent = true })
map('n', '<C-j>', function() require('Navigator').down() end, { desc = 'Move down', silent = true })
map('n', '<C-k>', function() require('Navigator').up() end, { desc = 'Move up', silent = true })
map('n', '<C-l>', function() require('Navigator').right() end, { desc = 'Move right', silent = true })

map('n', '<leader>r', '<cmd>RustLsp runnables<cr>', { desc = 'Rust runnables', silent = true })

-- Native diagnostics / quickfix
map('n', '<leader>xw', function() vim.diagnostic.setqflist { open = true } end, { desc = 'Workspace diagnostics' })
map('n', '<leader>xd', function()
  vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(0)), 'r')
  vim.cmd.copen()
end, { desc = 'Document diagnostics' })
map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Open quickfix list' })
map('n', '<leader>xl', function() vim.diagnostic.setloclist { open = true } end, { desc = 'Document diagnostics loclist' })

-- Git
map('n', '<leader>tb', function() require('gitsigns').toggle_current_line_blame() end, { desc = 'Toggle line blame', silent = true })
map('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = 'Git blame', silent = true })
