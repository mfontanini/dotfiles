return {
  "ibhagwan/fzf-lua",
  commit = "addb648ffe152c353232e8a88ff1364cbcf1ed1b",
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
