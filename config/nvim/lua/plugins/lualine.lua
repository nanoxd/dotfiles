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

-- Make a global table
wordCount = {}
-- Now add a function to it for the job needed
function wordCount.getWords()
  if
    vim.bo.filetype == 'md'
    or vim.bo.filetype == 'txt'
    or vim.bo.filetype == 'markdown'
    or vim.bo.filetype == 'mdx'
  then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. ' word'
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. ' words'
    else
      return tostring(vim.fn.wordcount().words) .. ' words'
    end
  else
    return 'Not a text file'
  end
end

local function place()
  local colPre = 'C:'
  local col = '%c'
  local linePre = ' L:'
  local line = '%l/%L'
  return string.format('%s%s%s%s', colPre, col, linePre, line)
end

-- adapted from https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return '󰑋 ' .. recording_register
  end
end

local function window() return vim.api.nvim_win_get_number(0) end

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
        component_separators = { ' ', ' ' },
        section_separators = { left = '', right = '' },
        icons_enabled = true,
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(s) return mode_map[s] or s end,
          },
        },
        lualine_c = {
          { 'diagnostics', sources = { 'nvim_diagnostic' } },
          function() return '%=' end,
          {
            'filename',
            file_status = true,
            path = 0,
            shorting_target = 40,
            symbols = {
              modified = '󰐖', -- Text to show when the file is modified.
              readonly = '', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for new created file before first writting
            },
          },
          {
            wordCount.getWords,
            color = { fg = '#16161D', bg = '#DCD7BA' },
            separator = { left = '', right = '' },
            cond = function() return wordCount.getWords() ~= 'Not a text file' end,
          },
          {
            'searchcount',
          },
          {
            'selectioncount',
          },
          {
            show_macro_recording,
            color = { fg = '#16161D', bg = '#FF5D62' },
            separator = { left = '', right = '' },
          },
        },
        lualine_x = {
          {
            'fileformat',
            icons_enabled = true,
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
        },
        lualine_y = { nil },
        lualine_z = {
          { place, padding = { left = 1, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = { { window, color = { fg = '#26ffbb', bg = '#282828' } } },
        lualine_b = {
          {
            'diff',
            source = diff_source,
            color_added = '#a7c080',
            color_modified = '#ffdf1b',
            color_removed = '#ff6666',
          },
        },
        lualine_c = {
          function() return '%=' end,
          {
            'filename',
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = '󰐖', -- Text to show when the file is modified.
              readonly = '', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for new created file before first writting
            },
          },
        },
        lualine_x = {
          { place, padding = { left = 1, right = 1 } },
        },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
