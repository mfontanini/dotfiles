-- nvim terminal title
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
  pattern = { "*.tf", "*.tfvars" },
  command = "set filetype=hcl",
})

-- markdown formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  command = "set textwidth=120 fo+=aw wrap",
})

-- Open terminal on insert mode
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter"}, {
  pattern = "term://*",
  command = "startinsert",
})
