-- Misc

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight-storm"
lvim.builtin.lualine.style = "default" -- or "none"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

vim.opt.spell = true
vim.opt.spelllang = { "en" }

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "json",
  "lua",
  "python",
  "rust",
  "yaml",
}

-- Key maps

local function find_project_files()
  require("lvim.core.telescope.custom-finders").find_project_files({ path_display = { "absolute" } })
end

lvim.leader = "space"
lvim.keys.normal_mode["<C-a>"] = vim.lsp.buf.definition
lvim.keys.normal_mode["<C-a>"] = vim.lsp.buf.definition
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-p>"] = find_project_files
lvim.keys.normal_mode["<C-f>"] = ":Telescope live_grep<cr>"
lvim.builtin.comment.toggler = {
  line = '<C-/>',
  block = 'gb'
}
lvim.keys.visual_mode["<C-/>"] = "<Plug>(comment_toggle_linewise_visual)"
lvim.keys.normal_mode["<ESC>"] = ":nohl<cr>"

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.which_key.mappings.l["o"] = { "<cmd>RustOpenExternalDocs<cr>", "Open external docs" }
lvim.builtin.which_key.mappings.l["e"] = { "<cmd>RustRunnables<cr>", "Rust runnables" }
lvim.builtin.which_key.mappings.b["c"] = { "<cmd>BufferKill<cr>", "Close buffer" }
lvim.builtin.which_key.mappings.b["a"] = {
  "<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>",
  "Close all but this one",
};
lvim.builtin.which_key.mappings.b["r"] = { "<cmd>Telescope oldfiles<cr>", "Recent" }

local ok, telescope_actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = telescope_actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = telescope_actions.move_selection_previous
lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = telescope_actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = telescope_actions.move_selection_previous

-- ------------
-- LSP settings
-- ------------

local cmp = require("cmp")
lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping.confirm({ select = true })

-- No snippets
for _, value in pairs(lvim.builtin.cmp.sources) do
  if value.name == "nvim_lsp" then
    value.entry_filter = function(entry, ctx)
      local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
      if kind == "Snippet" then
        return false
      end
      if kind == "Text" then
        return false
      end
      return true
    end
    break
  end
end

-----------------------------------
-- Navigation
-----------------------------------

-- Switch between tabs
lvim.keys.normal_mode["<space>["] = ":bprev<cr>"
lvim.keys.normal_mode["<space>]"] = ":bnext<cr>"

-- Control-C is ESC
lvim.keys.normal_mode["<C-c>"] = "<ESC>"

lvim.keys.normal_mode["<C-j>"] = "<C-D>zz"
lvim.keys.normal_mode["<C-k>"] = "<C-U>zz"
lvim.keys.visual_mode["<C-j>"] = "<C-D>zz"
lvim.keys.visual_mode["<C-k>"] = "<C-U>zz"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.remove_keymaps = { "<C-k>" }


vim.opt.relativenumber = true
vim.opt.colorcolumn = "120"
vim.opt.guicursor = "i:block-blinkwait50-blinkon200-blinkoff150"

-----------------------------------
--- File type configs
-----------------------------------

-- justfiles
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "justfile" },
  command = "set syntax=make",
})

-- cmake
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "CMakeLists.txt" },
  command = "set syntax=cmake",
})

-- jenkinsfiles
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Jenkinsfile", "*.pipeline" },
  command = "set syntax=groovy",
})

-- run black on python save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.py" },
  command = "silent !black -q %",
})

-- markdown
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  command = "set textwidth=120 fo+=aw wrap",
})

-- auto-open nvim-tree
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = open_nvim_tree
})

------------------------------------
--- Terminal
------------------------------------

lvim.keys.normal_mode["<leader>1"] = ":1ToggleTerm<CR>"
lvim.keys.normal_mode["<leader>2"] = ":2ToggleTerm<CR>"
lvim.keys.normal_mode["<leader>3"] = ":3ToggleTerm<CR>"

-- Terminal mode
lvim.keys.term_mode["<ESC>"] = "<C-\\><C-n>"
lvim.keys.term_mode["<C-space>"] = "<C-\\><C-n><cmd>ToggleTerm<cr>"

-- Start on insert mode.
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")

------------------------------------
-- Custom plugins
------------------------------------

require("custom")
