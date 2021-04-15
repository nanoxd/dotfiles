local utils = require('utils')

-- Telescope Bindings
utils.map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
utils.map('n', '<leader>;', '<cmd>Telescope buffers<cr>')
utils.map('n', '\\', '<cmd>Telescope live_grep<cr>')
