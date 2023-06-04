return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    version = false,
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    },
    keys = {
      { '<C-p>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>;', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '\\', '<cmd>Telescope live_grep<cr>', desc = 'Grep in directory' },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end
  },
}
