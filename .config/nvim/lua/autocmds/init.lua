require("autocmds/enter")
require("autocmds/pre")
require("autocmds/post")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 0
    vim.opt_local.formatoptions:remove("t")
  end,
})
