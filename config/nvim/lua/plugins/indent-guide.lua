return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    indent = { char = '┊' },
    -- Highlight the current Treesitter scope with a solid guide
    scope = { char = '│', show_start = false, show_end = false },
    exclude = { filetypes = { 'lazy', 'mason' } },
  },
}
