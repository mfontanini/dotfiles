return {
  {
    "nvim-lualine/lualine.nvim",
    commit = "0a5a66803c7407767b799067986b4dc3036e1983", 
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
