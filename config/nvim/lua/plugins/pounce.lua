return {
  'rlane/pounce.nvim',
  config = function()
    local pounce = require 'pounce'
    pounce.setup {
      accept_keys = 'NTESIROAGJKDFVBYMCXWPQZ',
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>h', ':Pounce<CR>', { silent = true, desc = 'Pounce' })
    vim.keymap.set('n', '<leader>H', ':PounceRepeat<CR>', { silent = true, desc = 'Pounce Repeat' })
  end,
}
