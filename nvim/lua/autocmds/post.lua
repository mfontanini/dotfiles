-- Highlight text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  desc = "Highlight text on yank",
  callback = function()
    vim.highlight.on_yank { higroup = "Search", timeout = 100 }
  end,
})

-- Auto save when leaving a buffer
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
    end
  end,
})

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = bufnr,
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "Cargo.toml",
  callback = function()
    local output = vim.fn.system("cargo metadata --format-version 1")
    if vim.v.shell_error ~= 0 then
      error("cargo failure: " .. output)
    end
  end,
})

-- shfmt formatting
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.sh" },
  command = "silent %!shfmt %",
})
