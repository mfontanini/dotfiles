return {
  "nvim-lualine/lualine.nvim",
  commit = "05d78e9fd0cdfb4545974a5aa14b1be95a86e9c9", 
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("lualine").setup {
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      }
    }
  end,
}
