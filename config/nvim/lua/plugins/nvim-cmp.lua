return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = { preset = 'super-tab' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
    --
    -- trigger = { signature_help = { enabled = true } },

    -- windows = {
    --   autocomplete = {
    --     draw = {
    --       columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
    --     },
    --   },
    -- },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
      },
    },

    -- experimental auto-brackets support
    -- completion = { accept = { auto_brackets = { enabled = true } } }

    -- experimental signature help support
    -- signature = { enabled = true }
  },
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
-- return {
--   'hrsh7th/nvim-cmp',
--   event = 'InsertEnter',
--   dependencies = {
--     'hrsh7th/cmp-nvim-lsp',
--     'ray-x/cmp-treesitter',
--     'hrsh7th/cmp-buffer', -- source for text in buffer
--     'hrsh7th/cmp-path', -- source for file system paths
--     'hrsh7th/cmp-cmdline',
--     'hrsh7th/cmp-vsnip',
--     'onsails/lspkind.nvim', -- vscode-like pictograms
--     {
--       'L3MON4D3/LuaSnip',
--       -- follow latest release.
--       version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
--       -- install jsregexp (optional!).
--       build = 'make install_jsregexp',
--     },
--     'saadparwaiz1/cmp_luasnip', -- for autocompletion
--     'rafamadriz/friendly-snippets', -- useful snippets
--   },
--   config = function()
--     local cmp = require 'cmp'
--     local luasnip = require 'luasnip'
--     local lspkind = require 'lspkind'
--
--     -- loads vscode style snippets from friendly-snippets
--     require('luasnip.loaders.from_vscode').lazy_load()
--
--     cmp.setup {
--       completion = {
--         completeopt = 'menu,menuone,preview,noselect',
--       },
--       snippet = {
--         expand = function(args) luasnip.lsp_expand(args.body) end,
--       },
--       -- sources for autocompletion
--       sources = cmp.config.sources {
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' }, -- snippets
--         { name = 'buffer' }, -- text within current buffer
--         { name = 'path' }, -- file system paths
--       },
--       mapping = cmp.mapping.preset.insert {
--         ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
--         ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
--         ['<C-e>'] = cmp.mapping.abort(), -- close completion window
--         ['<CR>'] = cmp.mapping.confirm { select = false },
--       },
--       formatting = {
--         format = lspkind.cmp_format {
--           maxwidth = 50,
--           ellipsis_char = '…',
--         },
--       },
--     }
--   end,
-- }
