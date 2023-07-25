-- Title
vim.api.nvim_create_autocmd("BufEnter", {
  command = ":let &titlestring = expand(\"%:t\") .. ' [nvim]' |  set title",
})

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

-- terraform formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tf" },
  command = "set filetype=hcl",
})

-- markdown formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  command = "set textwidth=120 fo+=aw wrap",
})

-- autosave when changing buffers
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
    end
  end,
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

-- Open terminal on insert mode.
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter"}, {
  pattern = "term://*",
  command = "startinsert",
})

