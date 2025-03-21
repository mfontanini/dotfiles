return {
  "nvim-treesitter/nvim-treesitter",
  commit = "5f38dffb6a07669a678f073bfe0f62b1a020dffc",
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
