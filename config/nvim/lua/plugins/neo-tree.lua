return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  branch = 'v3.x',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = {
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = 'open_default',
    },
  },
}
