return {
  {
    "nvim-lualine/lualine.nvim",
    commit = "2248ef254d0a1488a72041cfb45ca9caada6d994", 
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
