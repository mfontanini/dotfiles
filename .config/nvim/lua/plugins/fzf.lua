return {
  "ibhagwan/fzf-lua",
  commit = "394ddb2b80c58731c09b5775ca5d05d578b1de3d",
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
