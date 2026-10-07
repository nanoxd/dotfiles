return {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = { icons = { package_installed = '✓', package_pending = '➜', package_uninstalled = '✗' } },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = { 'stylua', 'black', 'isort', 'prettierd' },
      auto_update = false,
      integrations = { ['mason-lspconfig'] = false, ['mason-null-ls'] = false, ['mason-nvim-dap'] = false },
    },
  },
}
