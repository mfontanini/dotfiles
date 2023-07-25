vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.shada = "!,'32,<50,s10,h"
vim.opt.pumheight = 16
vim.opt.colorcolumn = "120"
vim.opt.guicursor = "i:block-blinkwait50-blinkon200-blinkoff150"

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.wo.relativenumber = true

-- Always show diagnostics column
vim.opt.signcolumn = "yes"

