return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local mason = require 'mason'
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    -- Set capabilities for all servers (blink.cmp handles this)
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    })

    -- Server-specific config
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    })

    require('mason-lspconfig').setup {
      ensure_installed = {
        'ts_ls',
        'html',
        'cssls',
        'tailwindcss',
        'lua_ls',
        'rust_analyzer',
        'denols',
      },
      automatic_enable = true,
    }

    -- Diagnostic config with signs
    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = '󰠠 ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
    }

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

        opts.desc = 'Show LSP implementations'
        keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

        opts.desc = 'Show LSP type definitions'
        keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        opts.desc = 'See available code actions'
        keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

        opts.desc = 'Smart rename'
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        opts.desc = 'Show buffer diagnostics'
        keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        opts.desc = 'Show line diagnostics'
        keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
      end,
    })
  end,
}
