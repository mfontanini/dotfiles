return {
  "akinsho/toggleterm.nvim",
  commit = "00c13dccc78c09fa5da4c5edda990a363e75035e",
  config = function()
    require("toggleterm").setup {
      direction = "float",
    }
  end
}