local keymap = vim.keymap.set
local fzf = require("fzf-lua")
local trouble = require("trouble")
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local neotest = require("neotest")

local function search_modified_git_files()
  return fzf.git_files({
    cmd = "git ls-files --exclude-standard -m"
  })
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
keymap("n", "<C-j>",  "<C-d>zz")
keymap("n", "<C-k>",  "<C-u>zz")
keymap("n", "<C-c>",  "<esc>")
keymap("n", "<C-s>",  ":w<cr>")
keymap("n", "<leader>",  "<Nop>")
keymap("n", "<ESC>", ":nohl<cr>")
keymap("n", "<leader>1", function() harpoon_ui.nav_file(1) end, { desc = "Harpoon file 1" })
keymap("n", "<leader>2", function() harpoon_ui.nav_file(2) end, { desc = "Harpoon file 2" })
keymap("n", "<leader>3", function() harpoon_ui.nav_file(3) end, { desc = "Harpoon file 3" })
keymap("n", "<leader>4", function() harpoon_ui.nav_file(4) end, { desc = "Harpoon file 4" })
keymap("n", "<leader>5", function() harpoon_ui.nav_file(5) end, { desc = "Harpoon file 5" })
keymap("n", "<leader>w",  ":w<cr>")
keymap("n", "<leader>q",  ":cclose<cr>")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("c", "<cr>",
  function()
    return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
  end,
  { expr = true }
)
keymap("n", "<leader>tt", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "[Toggle] Trouble"})
keymap("n", "<leader>tf",
  function()
    trouble.focus("diagnostics")
  end,
  { desc = "[Focus] Trouble"}
)
keymap("n", "<leader>tj",
  function()
    return trouble.next({skip_groups = true, jump = true})
  end,
  { desc = "[Trouble] Next"}
)
keymap("n", "<leader>tk",
  function()
    return trouble.prev({skip_groups = true, jump = true})
  end,
  { desc = "[Trouble] Previous"}
)

keymap("n", "<C-f>", fzf.live_grep, { desc = "Live grep" })
keymap("n", "<C-p>", fzf.files, { desc = "Find files" })
keymap("n", "<leader>?", fzf.oldfiles, { desc = "Find recently opened files" })
keymap("n", "<leader><space>", fzf.buffers, { desc = "Find existing buffers" })
keymap("n", "<leader>/",  fzf.lgrep_curbuf, { desc = "Find in current buffer" })
keymap("n", "<leader>sD", fzf.diagnostics_workspace, { desc = "[Search] Diagnostics globally" })
keymap("n", "<leader>sc", fzf.git_commits, { desc = "[Search] Git commits" })
keymap("n", "<leader>sC", fzf.git_bcommits, { desc = "[Search] Git buffer commits" })
keymap("n", "<leader>sb", fzf.git_branches, { desc = "[Search] Git branches" })
keymap("n", "<leader>st", fzf.git_status, { desc = "[Search] Git status" })

keymap("n", "<leader>e", "<cmd>Neotree toggle=true reveal_force_cwd<cr>", { desc = "[Toggle] Tree" })
keymap("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "[Toggle] Git blame" })
keymap("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "[Toggle] Git deleted lines" })
keymap("n", "<leader>th", harpoon_ui.toggle_quick_menu, { desc = "[Toggle] Harpoon menu" })

keymap("n", "<leader>G", "<cmd>:below G<cr>", { desc = "[Fugitive] Git" })
keymap("n", "<leader>m", function() fzf.git_files({ cmd = "git ls-files --exclude-standard -m" }) end, { desc = "[Search] Modified files" })

keymap("n", "<C-a>", vim.lsp.buf.definition, { desc = "[LSP] Jump to definition" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "[LSP] Jump to definition" })
keymap("n", "gs", fzf.lsp_document_symbols, { desc = "[LSP] Symbols" })
keymap("n", "gS", fzf.lsp_live_workspace_symbols, { desc = "[LSP] Symbols globally" })
keymap("n", "gr", fzf.lsp_references, { desc = "[Search] References" })
keymap("n", "<leader>C", "<cmd>RustLsp openCargo<cr>", { desc = "[Rust] Open Cargo.toml" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[LSP] Code actions" })
keymap("n", "<leader>re", rename_and_save, { desc = "[LSP] Rename" })
keymap("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[LSP] Next diagnostic" })
keymap("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[LSP] Previous diagnostic" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "[LSP] Hover documentation" })

keymap("n", "<leader>rd", "<cmd>RustLsp openDocs<cr>", { desc = "[Rust] Open external docs" })
keymap("n", "<leader>rr", "<cmd>RustRunnables<cr>", { desc = "[Rust] Runnables" })

keymap("n", "<leader>ha", harpoon_mark.add_file, { desc = "[Harpoon] Add file" })
keymap("n", "<leader>hn", harpoon_ui.nav_next, { desc = "[Harpoon] Next file" })
keymap("n", "<leader>hp", harpoon_ui.nav_prev, { desc = "[Harpoon] Previous file" })

keymap("n", "c", "\"_c", { noremap = true })
keymap("n", "x", "\"_x", { noremap = true })

keymap("n", "<leader>Tc", neotest.run.run, { desc = "[Test] Current" })
keymap("n", "<leader>Tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "[Test] File" })
keymap("n", "<leader>Ts", neotest.summary.toggle, { desc = "[Test] Toggle summary" })
keymap("n", "<leader>To", neotest.output_panel.toggle, { desc = "[Test] Toggle output panel" })

-- Visual
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("v", "<C-j>", "<C-d>zz")
keymap("v", "<C-k>", "<C-u>zz")

-- Terminal
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("t", "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
