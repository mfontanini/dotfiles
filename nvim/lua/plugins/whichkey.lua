return {
  "folke/which-key.nvim",
  commit = "38b990f6eabf62014018b4aae70a97d7a6c2eb88",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
        },
      },
    })

    local opts = {
      mode = "n",
      prefix = "<space>",
      silent = true,
      noremap = true,
      nowait = true,
    }

    local mappings = {
      b = {
        name = "Buffers",
        r = { "<cmd>Telescope oldfiles cwd_only=true<cr>", "Recent" },
      },
      l = {
        name = "LSP and more",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
        o = { "<cmd>RustOpenExternalDocs<cr>", "Open external docs" },
        e = { "<cmd>RustRunnables<cr>", "Rust runnables" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
        S = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace symbols",
        },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        c = { "<cmd>Telescope lsp_references<cr>", "References" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        t = { "<cmd>RustRunnables<cr>", "Rust runnables" },
      },
    }
    wk.register(mappings, opts)
  end,
}
