return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.0",
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
