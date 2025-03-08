local lspconfig = require("lspconfig")
lspconfig.ruff.setup {
  cmd = { "/home/matias/.cache/devenv/venv/bin/ruff", "server" },
}
lspconfig.pyright.setup {
  cmd = { "/home/matias/.cache/devenv/venv/bin/pyright-langserver", "--stdio" },
}

return {}
