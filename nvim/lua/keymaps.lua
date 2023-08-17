local keymap = vim.keymap.set
local telescope = require("telescope.builtin")

local function current_buffer_fuzzy_find()
  telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

local function recent_files()
  telescope.oldfiles({ cwd_only = true })
end

local function current_buffer_diagnostics()
  telescope.diagnostics({ bufnr = 0 })
end

-- Normal
keymap("n", "<C-h>",  "<C-w>h")
keymap("n", "<C-l>",  "<C-w>l")
keymap("n", "<C-j>",  "<C-d>zz")
keymap("n", "<C-k>",  "<C-u>zz")
keymap("n", "<C-c>",  "<ESC>")
keymap("n", "<C-s>",  ":w<CR>")
keymap("n", "<leader>",  "<Nop>")
keymap("n", "<ESC>", ":nohl<cr>")
keymap("n", "<leader>1", ":1ToggleTerm<CR>", { desc = "Toggle terminal 1" })
keymap("n", "<leader>2", ":2ToggleTerm<CR>", { desc = "Toggle terminal 2" })
keymap("n", "<leader>3", ":3ToggleTerm<CR>", { desc = "Toggle terminal 3" })

keymap("n", "<C-f>",  telescope.live_grep, { desc = "Live grep" })
keymap("n", "<C-p>",  telescope.find_files, { desc = "Find files" })
keymap("n", "<leader>?", recent_files, { desc = "Find recently opened files" })
keymap("n", "<leader><space>", telescope.buffers, { desc = "Find existing buffers" })
keymap("n", "<leader>/",  current_buffer_fuzzy_find, { desc = "Find in current buffer" })
keymap("n", "<leader>ss", telescope.lsp_document_symbols, { desc = "[Search] Symbols" })
keymap("n", "<leader>sS", telescope.lsp_dynamic_workspace_symbols, { desc = "[Search] Symbols globally" })
keymap("n", "<leader>sr", telescope.lsp_references, { desc = "[Search] References" })
keymap("n", "<leader>sd", current_buffer_diagnostics, { desc = "[Search] Diagnostics" })
keymap("n", "<leader>sD", telescope.diagnostics, { desc = "[Search] Diagnostics globally" })

keymap("n", "<C-a>", vim.lsp.buf.definition, { desc = "Jump to definition" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[LSP] Code actions" })
keymap("n", "<leader>re", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { desc = "Rename", expr = true })
keymap("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[LSP] Next diagnostic" })
keymap("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[LSP] Previous diagnostic" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "[LSP] Hover documentation" })

keymap("n", "<leader>rd", "<cmd>RustOpenExternalDocs<cr>", { desc = "[Rust] Open external docs" })
keymap("n", "<leader>rr", "<cmd>RustRunnables<cr>", { desc = "[Rust] Runnables" })

-- Visual
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("v", "<C-j>", "<C-d>zz")
keymap("v", "<C-k>", "<C-u>zz")

-- Terminal
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("t", "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
