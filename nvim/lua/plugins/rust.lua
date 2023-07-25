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
          hover_actions = {
            max_height = 8,
            auto_focus = true,
          },
        },
        server = {
          standalone = true,
          capabilities = rust_capabilities,
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          end,
        },
      }
    end,
  },
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
}

