return {
  'saghen/blink.pairs',
  dependencies = 'saghen/blink.lib',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile', 'CmdlineEnter' },
  -- Download the prebuilt matcher from the tagged GitHub release.
  build = function() require('blink.pairs').download():pwait(60000) end,

  ---@module 'blink.pairs'
  ---@type blink.pairs.Config
  opts = {
    mappings = { enabled = true },
    highlights = {
      enabled = true,
      matchparen = { enabled = true },
    },
  },
}
