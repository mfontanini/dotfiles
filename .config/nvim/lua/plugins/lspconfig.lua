return {
  "neovim/nvim-lspconfig",
  commit = "bc6ada4b0892b7f10852c0b8ca7209fd39a6d754",
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
