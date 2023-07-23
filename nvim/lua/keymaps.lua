local keymap = vim.keymap.set
local telescope = require("telescope.builtin")


-- Normal
keymap("n", "<C-f>",  telescope.live_grep)
keymap("n", "<C-h>",  "<C-w>h")
keymap("n", "<C-l>",  "<C-w>l")
keymap("n", "<C-j>",  "<C-d>")
keymap("n", "<C-k>",  "<C-u>")
keymap("n", "<C-c>",  "<ESC>")
keymap("n", "<C-s>",  ":w<CR>")
keymap("n", "<C-p>",  telescope.find_files)
keymap("n", "<Space>",  "<Nop>")
keymap("n", "<C-a>", vim.lsp.buf.definition)
keymap("n", "<ESC>", ":nohl<cr>")