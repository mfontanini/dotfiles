local lspconfig = require("lspconfig")
lspconfig.ruff_lsp.setup {}
lspconfig.pyright.setup {
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  end,
}

return {}
