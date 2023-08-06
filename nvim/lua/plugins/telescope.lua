return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
    version = "62ea5e58c7bbe191297b983a9e7e89420f581369",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local actions = require "telescope.actions"
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
            n = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor {

            },
          },
        },
      })
      telescope.load_extension("ui-select")
    end,
  },
}
