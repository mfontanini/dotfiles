local rust_capabilities = require("blink.cmp").get_lsp_capabilities()
rust_capabilities.textDocument.completion.completionItem.snippetSupport = false

return {
  {
    "mrcjkb/rustaceanvim",
    version = "5.15.4",
    ft = { "rust" },
    opts = {
      tools = {
        -- executor = require("rust-tools.executors").toggleterm,
        enable_clippy = false,
      },
      server = {
        capabilities = rust_capabilities,
        cmd_env = {
          CARGO_TARGET_DIR = "target/rust-analyzer",
        },
        default_settings = {
          ['rust-analyzer'] = {
            rustfmt = {
              extraArgs = { "+nightly" },
            },
            cargo = {
              check = {
                allTargets = true,
                features = "all",
              },
              loadOutDirsFromCheck = true,
              buildScripts = true,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force",
        {},
        opts or {})
    end
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

