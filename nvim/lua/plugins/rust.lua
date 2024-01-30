local rust_capabilities = require("cmp_nvim_lsp").default_capabilities()
rust_capabilities.textDocument.completion.completionItem.snippetSupport = false

return {
  {
    "simrat39/rust-tools.nvim",
    commit = "0cc8adab23117783a0292a0c8a2fbed1005dc645",
    config = function()
      local rt = require("rust-tools")
      rt.setup {
        tools = {
          executor = require("rust-tools.executors").toggleterm,
          hover_actions = {
            max_height = 8,
            auto_focus = true,
          },
        },
        server = {
          standalone = true,
          capabilities = rust_capabilities,
          cmd_env = {
            CARGO_TARGET_DIR = "target/rust-analyzer",
          },
          settings = {
            ['rust-analyzer'] = {
              rustfmt = {
                extraArgs = { "+nightly" },
              },
            },
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            require("utils/lsp").enable_cursor_highlighting(client, bufnr)
          end,
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    version = "v0.4.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "rust-lang/rust.vim",
    commit = "889b9a7515db477f4cb6808bef1769e53493c578",
  }
}

