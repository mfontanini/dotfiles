-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = bufnr,
  callback = function()
    vim.lsp.buf.format()
  end,
})


