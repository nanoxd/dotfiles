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

    -- TypeScript 7 ships a native language server (`tsc --lsp`). Use it when the project
    -- has no local TypeScript or a local 7.x, and keep ts_ls for projects pinned to older
    -- TypeScript so diagnostics match the version the project builds with.
    local tsc_bins = {}
    local function tsc_bin(root)
      if tsc_bins[root] == nil then
        local function major(bin)
          if vim.fn.executable(bin) ~= 1 then return nil end
          local out = vim.system({ bin, '--version' }, { text = true }):wait()
          local version = out.code == 0 and vim.version.parse(out.stdout or '')
          return version and version.major
        end
        local local_bin = vim.fs.joinpath(root, 'node_modules/.bin/tsc')
        local local_major = major(local_bin)
        if local_major then
          tsc_bins[root] = local_major >= 7 and local_bin or false
        else
          tsc_bins[root] = (major 'tsc' or 0) >= 7 and 'tsc' or false
        end
      end
      return tsc_bins[root]
    end

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
      local root = node_root or vim.fs.root(bufnr, { '.git' }) or vim.fn.getcwd()
      return tsc_bin(root) and 'tsc' or 'ts_ls', root
    end

    for _, server in ipairs { 'denols', 'tsc', 'ts_ls' } do
      vim.lsp.config(server, {
        root_dir = function(bufnr, on_dir)
          local owner, root = javascript_root(bufnr)
          if owner == server then on_dir(root) end
        end,
      })
    end

    vim.lsp.config('tsc', {
      cmd = function(dispatchers, config)
        return vim.lsp.rpc.start({ tsc_bin(config.root_dir) or 'tsc', '--lsp', '--stdio' }, dispatchers)
      end,
    })

    require('mason-lspconfig').setup {
      ensure_installed = {
        'tsc',
        'ts_ls',
        'html',
        'cssls',
        'tailwindcss',
        'emmylua_ls',
        'rust_analyzer',
        'denols',
      },
      -- rustaceanvim starts and configures its own Rust client.
      -- emmylua_ls replaces lua_ls, so skip a leftover lua_ls install.
      automatic_enable = { exclude = { 'rust_analyzer', 'lua_ls' } },
    }

    -- Diagnostic config with signs
    vim.diagnostic.config {
      severity_sort = true,
      -- Full messages under the cursor line only, signs everywhere else.
      virtual_lines = { current_line = true },
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
