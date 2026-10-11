return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- Load at startup so oil, not netrw, opens directory buffers like `nvim .`.
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    view_options = {
      is_always_hidden = function(name) return name == '.DS_Store' end,
    },
  },
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Explore files' },
  },
}
