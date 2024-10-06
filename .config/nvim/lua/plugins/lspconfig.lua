return {
  "neovim/nvim-lspconfig",
  commit = "a7f0f9c18baa70a3970ea18f9984e03b6f6c2e8a",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true)
        end
      end,
    })
  end,
}
