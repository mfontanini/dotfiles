return {
  "ibhagwan/fzf-lua",
  commit = "3de691fafd097177d10ebffb91dec5bec2cb30ed",
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
