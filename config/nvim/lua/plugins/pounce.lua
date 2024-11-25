return {
  'rlane/pounce.nvim',
  config = function()
    local pounce = require 'pounce'
    pounce.setup {
      accept_keys = 'NTESIROAGJKDFVBYMCXWPQZ',
    }

    vim.keymap.set({ 'n', 'v' }, 'h', ':Pounce<CR>', { silent = true, desc = 'Pounce' })
    vim.keymap.set('n', 'H', ':PounceRepeat<CR>', { silent = true, desc = 'Pounce Repeat' })
  end,
}
