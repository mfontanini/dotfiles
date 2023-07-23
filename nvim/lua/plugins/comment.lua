return {
  "numToStr/Comment.nvim",
  tag = "v0.8.0",
  config = function()
    require("Comment").setup {
      toggler = {
        line = "<C-/>",
      },
      opleader = {
        line = "<C-/>",
      },
    }
  end
}
