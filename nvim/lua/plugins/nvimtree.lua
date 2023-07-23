local function on_buffer_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<C-j>', "<C-d>", opts('Page down'))
  vim.keymap.set('n', '<C-k>', "<C-u>", opts('Page up'))
end

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

return {
  "nvim-tree/nvim-tree.lua",
  version = "3b62c6bf2c3f2973036aed609d02fd0ca9c3af35",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      view = {
        signcolumn = "yes",
        width = 40,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      git = {
        enable = true,
      },
      on_attach = on_buffer_attach,
    }
  end,
}
