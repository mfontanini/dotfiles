local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  "jose-elias-alvarez/null-ls.nvim",
  commit = "db09b6c691def0038c456551e4e2772186449f35",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.black,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end,
    })
  end,
}
