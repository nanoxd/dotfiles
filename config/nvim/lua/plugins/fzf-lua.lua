return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<C-p>', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader>;', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
    { '\\', '<cmd>FzfLua live_grep<cr>', desc = 'Grep in directory' },
    { '<leader>:', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    { '<leader>fc', '<cmd>FzfLua grep_cword<cr>', desc = 'Find string under cursor in cwd' },
    { '<leader>ft', '<cmd>TodoFzfLua<cr>', desc = 'Find TODOs' },
    { '<leader>fr', '<cmd>FzfLua resume<cr>', desc = 'Resume last picker' },
    { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Help tags' },
  },
  init = function()
    -- Route vim.ui.select (code actions, yank history) through fzf-lua on first use.
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require('fzf-lua').register_ui_select()
      return vim.ui.select(...)
    end
  end,
  opts = function()
    local actions = require 'fzf-lua.actions'
    return {
      files = { path_shorten = false },
      actions = {
        files = {
          true,
          ['ctrl-q'] = actions.file_sel_to_qf,
        },
      },
    }
  end,
}
