return {
  "smjonas/inc-rename.nvim",
  commit = "ed0f6f2b917cac4eb3259f907da0a481b27a3b7e",
  config = function()
    require("inc_rename").setup{
      post_hook = function(_)
        -- TODO consider only saving modified buffers; this does for now.
        vim.cmd("silent! wa")
      end
    }
  end
}
