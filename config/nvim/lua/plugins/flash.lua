return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { '<leader>h', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' },
    { '<leader>H', function() require('flash').treesitter() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter' },
  },
}
