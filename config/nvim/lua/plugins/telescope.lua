return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<C-p>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>;', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '\\', '<cmd>Telescope live_grep<cr>', desc = 'Grep in directory' },
    { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'Find string under cursor in cwd' },
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    }

    telescope.load_extension 'fzf'
  end,
}
