vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false,
})

vim.lsp.enable({"pyright", "ruff", "typescript-language-server", "gopls"})
