return {
  'windwp/nvim-autopairs',
  event = { 'InsertEnter' },
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  config = function()
    local autopairs = require 'nvim-autopairs'

    autopairs.setup {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
      },
    }

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'

    -- hook up to cmp
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
