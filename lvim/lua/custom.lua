vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local extension_path = vim.env.HOME .. '/.config/lvim/lldb-vscode'
local codelldb_path = extension_path .. 'codelldb'
local liblldb_path = extension_path .. 'liblldb.so'

local null_ls = require('null-ls')

lvim.plugins = {
  -- Parameter hints while calling functions.
  {
    "ray-x/lsp_signature.nvim",
    version = "v0.2.0",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  -- Cargo.toml dependency hints.
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('crates').setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        }
      }
    end,
  },
  -- Proper Rust LSP'ing.
  {
    "simrat39/rust-tools.nvim",
    -- ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
    config = function()
      require("rust-tools").setup {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require "rust-tools"
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        }
      }
    end,
  },
}
