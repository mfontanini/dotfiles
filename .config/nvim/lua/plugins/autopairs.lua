return {
  'windwp/nvim-autopairs',
  commit = "0f04d78619cce9a5af4f355968040f7d675854a1",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup()
  end
}
