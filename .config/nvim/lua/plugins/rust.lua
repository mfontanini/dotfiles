local rust_capabilities = require("blink.cmp").get_lsp_capabilities()

return {
  {
    "mrcjkb/rustaceanvim",
    version = "6.3.0",
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
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            completion = {
              callable = {
                snippets = "add_parentheses",
              },
              postfix = {
                enable = false,
              },
              fullFunctionSignatures = {
                enable = true,
              },
            },
            assist = {
              preferSelf = true,
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
    commit = "fd2bbca7aa588f24ffc3517831934b4c4a9588e9",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "rust-lang/rust.vim",
    commit = "889b9a7515db477f4cb6808bef1769e53493c578",
  }
}

