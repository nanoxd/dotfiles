local utils = require('utils')

-- make `-` and `_` work like `o` and `O` without leaving you stuck in insert
utils.map('n', '-', 'o<esc>')
utils.map('n', '_', 'O<esc>')

-- Expand %% into the directory of the current file
cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")
-- Save with sudo
cmd("cmap w!! %!sudo tee > /dev/null %")

utils.map('n', 'gV', '`[v`]') -- Highlight last inserted text
utils.map('n', 'vv', '<C-w>v', { silent = true }) -- Generate new vertical split
utils.map('n', 'Q', '')
utils.map('n', 'q:', '')
utils.map('n', 'J', 'mjJ`j') -- Join lines and restore cursor location
utils.map('n', '<leader>ps', [[<cmd>PackerSync<cr>]], { silent = true }) -- Run PackerSync

-- Smart `0`
-- `0` goes to the beginning of the text on first press and to the beginning
--" of the line on second press. It alternates afterwards.
utils.map('n', '0', "virtcol('.') - 1 <= indent('.') && col('.') > 1 ? '0' : '_'", { expr = true })

utils.map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { silent = true })

-- Telescope Bindings
utils.map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
utils.map('n', '<leader>;', '<cmd>Telescope buffers<cr>')
utils.map('n', '\\', '<cmd>Telescope live_grep<cr>')

utils.map('n', '<leader>p', '<cmd>Telescope neoclip<cr>') -- Open Clipboard history
utils.map('v', '<leader>y', ':OSCYank<cr>', { silent = true }) -- Copy to Clipboard
vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]

-- Navigator Bindings
utils.map('n', '<C-h>', '<cmd>lua require("Navigator").left()<cr>', { silent = true })
utils.map('n', '<C-j>', '<cmd>lua require("Navigator").down()<cr>', { silent = true })
utils.map('n', '<C-k>', '<cmd>lua require("Navigator").up()<cr>', { silent = true })
utils.map('n', '<C-l>', '<cmd>lua require("Navigator").right()<cr>', { silent = true })

utils.map('n', '<leader>s', '<cmd>SymbolsOutline<cr>', { silent = true }) -- Symbols Outline
utils.map('n', '<leader>S', '<cmd>lua require("spectre").open()<cr>') -- Open Spectre

utils.map('n', '<leader>t', '<cmd>Trouble<cr>', { silent = true }) -- Open Trouble

-- Git

utils.map('n', '<leader>tb', [[<cmd>lua require'gitsigns'.toggle_current_line_blame()<cr>]], { silent = true }) -- Toggle single line git commit context
utils.map('n', '<leader>gb', [[:Git blame<cr>]], { silent = true })
