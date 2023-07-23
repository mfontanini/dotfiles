return {
    'windwp/nvim-autopairs',
    commit = "ae5b41ce880a6d850055e262d6dfebd362bb276e",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
}
