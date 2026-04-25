return {
  "ibhagwan/fzf-lua",
  commit = "83f7195972538beee3a40932b38ccd86c8cc0f06",
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
