local keymap = vim.keymap.set
local telescope = require("telescope.builtin")
local trouble = require("trouble")
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

local function current_buffer_fuzzy_find()
  telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    previewer = false,
  })
end

local function recent_files()
  telescope.oldfiles({ cwd_only = true })
end

local function search_modified_git_files()
  telescope.git_files({
    git_command = { "git", "ls-files", "--exclude-standard", "-m" }
  })
end

local function current_buffer_diagnostics()
  telescope.diagnostics({ bufnr = 0 })
end

local function rename_and_save()
  vim.ui.input({ prompt = "Name: ", default = vim.fn.expand("<cword>")}, function(name)
    local params = vim.lsp.util.make_position_params()
    params.newName = name

    vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ctx, _)
      if err and err.message then
        return
      end

      if not result or vim.tbl_isempty(result) then
        return
      end

      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
      vim.cmd("silent! wa") 
    end)
  end)
end

-- Insert
keymap("i", "jj",  "<ESC>")

-- Normal
keymap("n", "<C-h>",  "<C-w>h")
keymap("n", "<C-l>",  "<C-w>l")
keymap("n", "<C-j>",  "<C-d>zz")
keymap("n", "<C-k>",  "<C-u>zz")
keymap("n", "<C-c>",  "<esc>")
keymap("n", "<C-s>",  ":w<cr>")
keymap("n", "<leader>",  "<Nop>")
keymap("n", "<ESC>", ":nohl<cr>")
keymap("n", "<leader>1", "<cmd>1ToggleTerm<cr>", { desc = "Toggle terminal 1" })
keymap("n", "<leader>2", "<cmd>2ToggleTerm<cr>", { desc = "Toggle terminal 2" })
keymap("n", "<leader>3", "<cmd>3ToggleTerm<cr>", { desc = "Toggle terminal 3" })
keymap("n", "<leader>w",  ":w<cr>")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("c", "<cr>",
  function()
    return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
  end,
  { expr = true }
)
keymap("n", "<leader>tr", trouble.toggle, { desc = "[Toggle] Trouble"})
keymap("n", "<leader>tj",
  function()
    return trouble.next({skip_groups = true, jump = true})
  end,
  { desc = "[Trouble] Next"}
)
keymap("n", "<leader>tk",
  function()
    return trouble.previous({skip_groups = true, jump = true})
  end,
  { desc = "[Trouble] Previous"}
)

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
keymap("n", "<leader>sh", "<cmd>Telescope harpoon marks<cr>", { desc = "[Search] Harpoon marks" })
keymap("n", "<leader>sc", telescope.git_commits, { desc = "[Search] Git commits" })
keymap("n", "<leader>sC", telescope.git_bcommits, { desc = "[Search] Git buffer commits" })
keymap("n", "<leader>sb", telescope.git_branches, { desc = "[Search] Git branches" })
keymap("n", "<leader>st", telescope.git_status, { desc = "[Search] Git status" })

keymap("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", { desc = "[Toggle] Tree" })
keymap("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "[Toggle] Git blame" })
keymap("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "[Toggle] Git deleted lines" })
keymap("n", "<leader>th", harpoon_ui.toggle_quick_menu, { desc = "[Toggle] Harpoon menu" })

keymap("n", "<leader>G", "<cmd>:below G<cr>", { desc = "[Fugitive] Git" })
keymap("n", "<leader>m", search_modified_git_files, { desc = "[Search] Modified files" })

keymap("n", "<C-a>", vim.lsp.buf.definition, { desc = "[LSP] Jump to definition" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "[LSP] Jump to definition" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[LSP] Code actions" })
keymap("n", "<leader>re", rename_and_save, { desc = "[LSP] Rename" })
keymap("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[LSP] Next diagnostic" })
keymap("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[LSP] Previous diagnostic" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "[LSP] Hover documentation" })

keymap("n", "<leader>rd", "<cmd>RustOpenExternalDocs<cr>", { desc = "[Rust] Open external docs" })
keymap("n", "<leader>rr", "<cmd>RustRunnables<cr>", { desc = "[Rust] Runnables" })

keymap("n", "<leader>ha", harpoon_mark.add_file, { desc = "[Harpoon] Add file" })
keymap("n", "<leader>hn", harpoon_ui.nav_next, { desc = "[Harpoon] Next file" })
keymap("n", "<leader>hp", harpoon_ui.nav_prev, { desc = "[Harpoon] Previous file" })

keymap("n", "c", "\"_c", { noremap = true })
keymap("n", "x", "\"_x", { noremap = true })

-- Visual
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("v", "<C-j>", "<C-d>zz")
keymap("v", "<C-k>", "<C-u>zz")

-- Terminal
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("t", "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
