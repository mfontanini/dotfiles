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
  end,
}
