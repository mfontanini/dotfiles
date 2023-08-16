local keymap = vim.keymap.set
local telescope = require("telescope.builtin")

-- Normal
keymap("n", "<C-h>",  "<C-w>h")
keymap("n", "<C-l>",  "<C-w>l")
keymap("n", "<C-j>",  "<C-d>zz")
keymap("n", "<C-k>",  "<C-u>zz")
keymap("n", "<C-c>",  "<ESC>")
keymap("n", "<C-s>",  ":w<CR>")
keymap("n", "<leader>",  "<Nop>")
keymap("n", "<C-a>", vim.lsp.buf.definition, { desc = "Jump to definition" })
keymap("n", "<ESC>", ":nohl<cr>")
keymap("n", "<leader>1", ":1ToggleTerm<CR>", { desc = "Toggle terminal 1" })
keymap("n", "<leader>2", ":2ToggleTerm<CR>", { desc = "Toggle terminal 2" })
keymap("n", "<leader>3", ":3ToggleTerm<CR>", { desc = "Toggle terminal 3" })

keymap("n", "<C-f>",  telescope.live_grep, { desc = "Live grep" })
keymap("n", "<C-p>",  telescope.find_files, { desc = "Find files" })
keymap("n", "<leader>?", telescope.oldfiles, { desc = '[?] Find recently opened files' })
keymap("n", "<leader><space>", telescope.buffers, { desc = '[ ] Find existing buffers' })
keymap("n", "<leader>/",  function()
  telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)

-- Visual
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("v", "<C-j>", "<C-d>zz")
keymap("v", "<C-k>", "<C-u>zz")

-- Terminal
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("t", "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
