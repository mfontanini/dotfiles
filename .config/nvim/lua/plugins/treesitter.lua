return {
  "nvim-treesitter/nvim-treesitter",
  commit = "bcd0b26607c1a4336c392285a9f13e31f514ccf2",
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
