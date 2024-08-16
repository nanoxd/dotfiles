vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "rust",
  command = "set expandtab tabstop=4 softtabstop=4 shiftwidth=4",
})
