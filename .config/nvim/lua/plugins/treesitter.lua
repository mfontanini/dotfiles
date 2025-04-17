return {
  "nvim-treesitter/nvim-treesitter",
  commit = "684eeac91ed8e297685a97ef70031d19ac1de25a",
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
