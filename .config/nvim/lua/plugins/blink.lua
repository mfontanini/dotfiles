return {
  'saghen/blink.cmp',

  version = 'v1.6.0',

  opts = {
    keymap = { 
      preset = 'default',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
    },

    completion = {
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },

    sources = {
      default = { 'lsp', 'path', 'buffer', 'cmdline' },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<cr>'] = { 'accept', 'fallback' },
      },
      completion = {
        list = {
          selection = {
            auto_insert = false,
          },
        },
      },
    },
  },

  opts_extend = { "sources.default" }
}

