return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 0,
    icons = {
      rules = false,
      breadcrumb = ' ', -- symbol used in the command line area that shows your active key combo
      separator = '󱦰  ', -- symbol used between a key and it's label
      group = '󰹍 ', -- symbol prepended to a group
    },
  },
}
