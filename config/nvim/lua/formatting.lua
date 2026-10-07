vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserIndentation', { clear = true }),
  pattern = 'rust',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})
