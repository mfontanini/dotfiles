return {
  'windwp/nvim-autopairs',
  commit = "3d02855468f94bf435db41b661b58ec4f48a06b7",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup()
  end
}
