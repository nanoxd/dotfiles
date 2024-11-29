local mode_map = {
  ['COMMAND'] = '!',
  ['CONFIRM'] = 'Y?',
  ['EX'] = 'X',
  ['INSERT'] = 'I',
  ['MORE'] = 'M',
  ['NORMAL'] = 'N',
  ['O-PENDING'] = 'N?',
  ['REPLACE'] = 'R',
  ['S-BLOCK'] = 'SB',
  ['S-LINE'] = 'SL',
  ['SELECT'] = 'S',
  ['SHELL'] = 'SH',
  ['TERMINAL'] = 'T',
  ['V-BLOCK'] = 'VB',
  ['V-LINE'] = 'VL',
  ['V-REPLACE'] = 'VR',
  ['VISUAL'] = 'V',
}

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    opt = true,
  },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(s) return mode_map[s] or s end,
          },
        },
      },
    }
  end,
}
