return {
  {
    "nvim-lualine/lualine.nvim",
    commit = "9fef261b53fbe3a2ef01ee9667f6fde064b1ed10", 
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("lualine").setup {
        sections = {
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              sources = { "nvim_workspace_diagnostic" },
              sections = { "error", "warn" },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
            "lsp_progress",
          },
        }
      }
    end,
  },
  {
    "arkav/lualine-lsp-progress",
    commit = "56842d097245a08d77912edf5f2a69ba29f275d7",
  }
}
