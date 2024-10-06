local lspconfig = require("lspconfig")
lspconfig.pyright.setup {
  cmd = { "/home/matias/.cache/devenv/venv/bin/pyright-langserver", "--stdio" },
}

return {}
