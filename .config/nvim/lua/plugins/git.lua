return {
  {
    "tpope/vim-fugitive",
    commit = "b3b838d690f315a503ec4af8c634bdff3b200aaf",
    config = function()
      vim.keymap.del("n", "y<C-G>") 
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "v0.8.1",
    opts = {
      signcolumn = true,
      current_line_blame_opts = {
        delay = 250,
      },
    },
  },
}
