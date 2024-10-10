local lspconfig = require("lspconfig")
lspconfig.ruff_lsp.setup {
  cmd = { "/home/matias/.cache/devenv/venv/bin/ruff-lsp" },
}
lspconfig.pyright.setup {
  cmd = { "/home/matias/.cache/devenv/venv/bin/pyright-langserver", "--stdio" },
}

return {}
