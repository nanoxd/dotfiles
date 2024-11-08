-- Better syntax highlighting
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter.configs'

    treesitter.setup {
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'css',
        'dockerfile',
        'gitignore',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'rust',
        'swift',
        'tsx',
        'typescript',
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',

            -- Or you can define your own textobjects like this
            --[[ ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
        }, ]]
          },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Leader>v',
          node_incremental = '<Leader>v',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    }
  end,
}
