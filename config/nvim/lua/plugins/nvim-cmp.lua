return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'onsails/lspkind.nvim', -- vscode-like pictograms
  },
}
