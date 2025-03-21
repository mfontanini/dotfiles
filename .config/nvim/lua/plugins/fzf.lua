return {
  "ibhagwan/fzf-lua",
  commit = "aeff8132009a7fc55c6c43bca4288d5ba26a5393",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept"
      },
    },
    grep = {
      hidden = true,
    }
  },
}
