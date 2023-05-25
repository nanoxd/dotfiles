return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = "Neotree",
  branch = "v2.x",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree"}
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = {
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
    },
  },
}
