-- justfiles formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "justfile" },
  command = "set syntax=make",
})

-- cmake formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "CMakeLists.txt" },
  command = "set syntax=cmake",
})

-- jenkinsfiles formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Jenkinsfile", "*.pipeline" },
  command = "set syntax=groovy",
})

-- markdown formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  command = "set textwidth=120 fo+=aw wrap",
})

-- rust file autoformat on save
local format_group = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_group,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  desc = "Highlight text on yank",
  callback = function()
    vim.highlight.on_yank { higroup = "Search", timeout = 100 }
  end,
})
