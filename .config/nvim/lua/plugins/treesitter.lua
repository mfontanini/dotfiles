return {
  "nvim-treesitter/nvim-treesitter",
  commit = "9636d5a3f4f531256fba147a30b882c44f28fae1",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup {
      ensure_installed = {
        "bash",
        "c",
        "json",
        "lua",
        "python",
        "rust",
        "yaml",
        "dockerfile",
        "cmake",
        "hcl",
      },
      indent = { enable = true },
      highlight = {
        enable = true,
      },
    }
  end
}
