return {
  "neovim/nvim-lspconfig",
  commit = "4d38bece98300e3e5cd24a9aa0d0ebfea4951c16",
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
