return {
  {
    "hrsh7th/nvim-cmp",
    commit = "5260e5e8ecadaf13e6b82cf867a909f54e15fd07", 
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local context = require("cmp.config.context")

      cmp.setup({
        preselect = cmp.PreselectMode.None,

        enabled = function()
          buftype = vim.api.nvim_buf_get_option(0, "buftype")
          -- don't autocomplete on prompts, such as telescope
          if buftype == "prompt" then
            return false
          end
          -- don't autocomplete inside a code comment
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end,

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        formatting = {
          format = function(_, vim_item)
            if vim_item.menu ~= nil then
              -- This keeps the ` (use std::potato::Potato)` if it exists or nothing otherwise
              vim_item.menu = string.match(vim_item.menu, "^ %(use .-%)")
            end
            return vim_item
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<ESC>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
              return kind ~= "Snippet"
            end,
          },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),

        completion = {
          keyword_length = 1,
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ['<C-j>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
          ['<C-k>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        }),
        sources = {
          { name = "cmdline" },
        }
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    version = "v0.3.1",
    config = function()
      require("lsp_signature").setup()
    end,
  },
}
