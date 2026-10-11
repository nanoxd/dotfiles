return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()
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

    -- Use one root decision so Deno and TypeScript never claim the same file.
    -- Lockfiles distinguish nested Node packages from a surrounding Deno project.
    local function javascript_root(bufnr)
      local node_root = vim.fs.root(bufnr, {
        'package-lock.json',
        'yarn.lock',
        'pnpm-lock.yaml',
        'bun.lockb',
        'bun.lock',
      })
      local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' })
      if deno_root and (not node_root or #deno_root >= #node_root) then return 'denols', deno_root end
      return 'ts_ls', node_root or vim.fs.root(bufnr, { '.git' }) or vim.fn.getcwd()
    end

    for _, server in ipairs { 'denols', 'ts_ls' } do
      vim.lsp.config(server, {
        root_dir = function(bufnr, on_dir)
          local owner, root = javascript_root(bufnr)
          if owner == server then on_dir(root) end
        end,
      })
    end

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
      -- rustaceanvim starts and configures its own Rust client.
      automatic_enable = { exclude = { 'rust_analyzer' } },
    }

    -- Diagnostic config with signs
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = true },
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

        -- Neovim's defaults cover the rest: grn rename, gra code action, grr references,
        -- gri implementation, grt type definition, gO symbols, K hover, [d ]d diagnostics.
        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>FzfLua lsp_references<CR>', opts)

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions<CR>', opts)

        opts.desc = 'Show LSP implementations'
        keymap.set('n', 'gi', '<cmd>FzfLua lsp_implementations<CR>', opts)

        opts.desc = 'Show workspace symbols'
        keymap.set('n', '<leader>fs', '<cmd>FzfLua lsp_live_workspace_symbols<CR>', opts)

        opts.desc = 'Show buffer diagnostics'
        keymap.set('n', '<leader>D', '<cmd>FzfLua diagnostics_document<CR>', opts)

        opts.desc = 'Show line diagnostics'
        keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', '<cmd>lsp restart<CR>', opts)

        vim.lsp.codelens.enable(true, { bufnr = ev.buf })
      end,
    })
  end,
}
