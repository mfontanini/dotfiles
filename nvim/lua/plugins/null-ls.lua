return {
  "jose-elias-alvarez/null-ls.nvim",
  commit = "db09b6c691def0038c456551e4e2772186449f35",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
}
