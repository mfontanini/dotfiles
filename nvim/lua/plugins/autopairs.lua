return {
  'windwp/nvim-autopairs',
  commit = "ae5b41ce880a6d850055e262d6dfebd362bb276e",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup()

    local Rule = require("nvim-autopairs.rule")
    local macro_regex = vim.regex("^[\\s]*#\\[")
    -- ideally this would be smarter and consider multi line
    local use_regex = vim.regex("^use ")
    npairs.get_rules("(")[1]:with_pair(function(opts)
      if macro_regex:match_str(opts.line) then
        return false
      end

      if use_regex:match_str(opts.line) then
        return false
      end
      
      return true
    end)


    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )
  end
}
