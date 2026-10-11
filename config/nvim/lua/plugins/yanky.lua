return {
  'gbprod/yanky.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    ring = { storage = 'shada' },
    highlight = { on_put = true, on_yank = true, timer = 150 },
  },
  keys = {
    { '<leader>p', '<cmd>YankyRingHistory<cr>', mode = { 'n', 'x' }, desc = 'Clipboard history' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before' },
    { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
    { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
  },
}
