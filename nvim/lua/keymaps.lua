local keymap = vim.keymap.set
local telescope = require("telescope.builtin")

-- Normal
keymap("n", "<C-f>",  telescope.live_grep)
keymap("n", "<C-h>",  "<C-w>h")
keymap("n", "<C-l>",  "<C-w>l")
keymap("n", "<C-j>",  "<C-d>zz")
keymap("n", "<C-k>",  "<C-u>zz")
keymap("n", "<C-c>",  "<ESC>")
keymap("n", "<C-s>",  ":w<CR>")
keymap("n", "<C-p>",  telescope.find_files)
keymap("n", "<Space>",  "<Nop>")
keymap("n", "<C-a>", vim.lsp.buf.definition)
keymap("n", "<ESC>", ":nohl<cr>")
keymap("n", "<Space>1", ":1ToggleTerm<CR>")
keymap("n", "<Space>2", ":2ToggleTerm<CR>")
keymap("n", "<Space>3", ":3ToggleTerm<CR>")

-- Visual
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("v", "<C-j>", "<C-d>zz")
keymap("v", "<C-k>", "<C-u>zz")

-- Terminal
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("t", "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
