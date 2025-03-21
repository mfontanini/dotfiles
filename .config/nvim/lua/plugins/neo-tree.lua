return {
  "nvim-neo-tree/neo-tree.nvim",
  commit = "3.31.1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function() 
    local command = require("neo-tree.command")
    require("neo-tree").setup({
      window = {
        position = "current",
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
        window = {
          mappings = {
            ["<c-f>"] = "fzf_grep",
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            command.execute({ action = "close" })
          end
        },
      },
      default_component_configs = {
        type = {
          enabled = false,
        },
      },
      commands = {
        fzf_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require('fzf-lua').live_grep_native({cwd = path})
        end,
      },
    })
  end
  
}
