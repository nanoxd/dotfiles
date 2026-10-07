-- Parsers and queries for Neovim's native Treesitter highlighting.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'windwp/nvim-ts-autotag',
  },
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'
    treesitter.setup { install_dir = vim.fn.stdpath 'data' .. '/site' }
    treesitter.install {
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
    }

    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
      group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
      callback = function(event)
        local filetype = vim.bo[event.buf].filetype
        local language = vim.treesitter.language.get_lang(filetype)
        -- Keep ordinary filetype behavior for buffers without an installed parser.
        if not language or not pcall(vim.treesitter.language.add, language) then return end
        if vim.treesitter.query.get(language, 'highlights') then vim.treesitter.start(event.buf, language) end
        if vim.treesitter.query.get(language, 'indents') then
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require('nvim-treesitter-textobjects').setup {
      select = { lookahead = true },
    }
    local captures = {
      af = '@function.outer',
      ['if'] = '@function.inner',
      ac = '@class.outer',
      ic = '@class.inner',
    }
    for key, capture in pairs(captures) do
      vim.keymap.set(
        { 'x', 'o' },
        key,
        function() require('nvim-treesitter-textobjects.select').select_textobject(capture, 'textobjects') end,
        { desc = 'Select ' .. capture }
      )
    end

    require('nvim-ts-autotag').setup {}
  end,
}
