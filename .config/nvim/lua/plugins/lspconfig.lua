return  {
  {
    "neovim/nvim-lspconfig",
    commit = "fb733ac734249ccf293e5c8018981d4d8f59fa8f",
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
  },
  {
    "RRethy/vim-illuminate",
    commit = "19cb21f513fc2b02f0c66be70107741e837516a1",
  },
}
