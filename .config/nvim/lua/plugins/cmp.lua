local lspkind_comparator = function(conf)
	local lsp_types = require("cmp.types").lsp
	return function(entry1, entry2)
		if entry1.source.name ~= "nvim_lsp" then
			if entry2.source.name == "nvim_lsp" then
				return false
			else
				return nil
			end
		end
		local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
		local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
		if kind1 == "Variable" and entry1:get_completion_item().label:match("%w*=") then
			kind1 = "Parameter"
		end
		if kind2 == "Variable" and entry2:get_completion_item().label:match("%w*=") then
			kind2 = "Parameter"
		end
    local is_trait_fn1 = entry1.completion_item.labelDetails.detail ~= nil
    local is_trait_fn2 = entry2.completion_item.labelDetails.detail ~= nil
    if is_trait_fn1 ~= is_trait_fn2 then
      return (is_trait_fn1 and 1 or 0) < (is_trait_fn2 and 1 or 0)
    end

		local priority1 = conf.kind_priority[kind1] or 0
		local priority2 = conf.kind_priority[kind2] or 0
		if priority1 == priority2 then
			return nil
		end
		return priority1 > priority2
	end
end

local label_comparator = function(entry1, entry2)
	return entry1.completion_item.label < entry2.completion_item.label
end

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

        sorting = {
          comparators = {
            lspkind_comparator({
              kind_priority = {
                Snippet = 0,
                Constructor = 1,
                Text = 1,
                TypeParameter = 1,
                Unit = 1,
                Value = 1,
                Keyword = 2,
                Class = 5,
                Color = 5,
                Module = 5,
                File = 8,
                Folder = 8,
                Interface = 10,
                Constant = 10,
                Enum = 10,
                Event = 10,
                Function = 13,
                Method = 14,
                Operator = 10,
                Reference = 10,
                Struct = 10,
                Property = 11,
                Variable = 12,
                Parameter = 13,
                EnumMember = 15,
                Field = 15,
              },
            }),
            label_comparator,
          },
        },

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
