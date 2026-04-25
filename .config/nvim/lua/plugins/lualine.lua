return {
  {
    "nvim-lualine/lualine.nvim",
    commit = "a905eeebc4e63fdc48b5135d3bf8aea5618fb21c", 
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
