return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
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
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            command.execute({ action = "close" })
          end
        },
      }
    })
  end
  
}
