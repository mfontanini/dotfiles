return {
  "nvim-treesitter/nvim-treesitter",
  commit = "4916d6592ede8c07973490d9322f187e07dfefac",
  build = ":TSUpdate",
  init = function()
    local expected_parsers = {
      "bash",
      "c",
      "cmake",
      "dockerfile",
      "hcl",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "sql",
      "yaml",
    }
    local installed_parsers = require('nvim-treesitter.config').get_installed()
    local new_parsers = vim.iter(expected_parsers)
      :filter(function(parser)
        return not vim.tbl_contains(installed_parsers, parser)
      end)
      :totable()
    require('nvim-treesitter').install(new_parsers)

    vim.api.nvim_create_autocmd('FileType', { 
      callback = function() 
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start) 
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
      end, 
    }) 
    end
}
