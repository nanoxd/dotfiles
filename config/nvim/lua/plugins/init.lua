return {

  -- UI
  {
    'nvim-mini/mini.tabline', -- Buffer list in the tabline
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim', -- Adds Git highlighting
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

        map('n', ']h', function() gitsigns.nav_hunk 'next' end, 'Next hunk')
        map('n', '[h', function() gitsigns.nav_hunk 'prev' end, 'Previous hunk')
        map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
        map(
          'x',
          '<leader>hs',
          function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          'Stage selection'
        )
        map(
          'x',
          '<leader>hr',
          function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          'Reset selection'
        )
        map('n', '<leader>hS', gitsigns.stage_buffer, 'Stage buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk_inline, 'Preview hunk')
        map('n', '<leader>hd', gitsigns.diffthis, 'Diff against index')
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle line blame')
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
      end,
    },
  },

  -- Tools
  'kevinhwang91/nvim-bqf', -- Make QuickFix better
  'lambdalisue/vim-suda', -- Sudo support in nvim
  'tpope/vim-fugitive', -- Git for Vim
  {
    'MagicDuck/grug-far.nvim',
    opts = {},
    keys = {
      {
        '<leader>S',
        function() require('grug-far').open() end,
        desc = 'Search and Replace',
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^9', -- Neovim 0.12+
    lazy = false, -- This plugin is already lazy
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'ruff_organize_imports', 'ruff_format' },
        swift = { 'swiftformat' },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { 'rustfmt', lsp_format = 'fallback' },
        -- Conform will run the first available formatter
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    },
    event = { 'BufWritePre' },
  },
}
