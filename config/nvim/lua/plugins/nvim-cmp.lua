return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
  },

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'super-tab' },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true },
      accept = { auto_brackets = { enabled = true } },
    },

    signature = { enabled = true },

    sources = {
      default = {
        'lazydev',
        'lsp',
        'path',
        'snippets',
        'buffer',
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
