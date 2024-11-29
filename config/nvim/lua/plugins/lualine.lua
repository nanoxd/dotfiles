return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    opt = true,
  },
  config = {
    options = {
      theme = 'auto',
    },
  },
}
