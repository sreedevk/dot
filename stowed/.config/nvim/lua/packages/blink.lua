return {
  {
    'saghen/blink.compat',
    -- use v2.* for blink.cmp v1.*
    version = '2.*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'Gelio/cmp-natdat', config = true },
      'kirasok/cmp-hledger',
    },
    event = { "InsertEnter", "CmdlineEnter" },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ["<C-k>"] = { 'select_prev', 'fallback' },
        ["<C-p>"] = { 'select_prev', 'fallback' },
        ["<C-j>"] = { 'select_next', 'fallback' },
        ["<C-n>"] = { 'select_next', 'fallback' },
        ["<C-b>"] = {
          function(cmp)
            cmp.scroll_documentation_up(4)
          end,
        },
        ["<C-f>"] = {
          function(cmp)
            cmp.scroll_documentation_down(4)
          end,
        },
        ["<C-e>"] = { 'cancel' },
        ["<CR>"] = { 'accept', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono'
      },

      cmdline = {
        enabled = false,
      },

      completion = {
        keyword = { range = 'full' },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1800
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        ghost_text = {
          enabled = false,
        },
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'natdat',
          'buffer',
          'hledger',
        },
        per_filetype = {
          sql = { 'dadbod' },
          lua = { inherit_defaults = true, 'lazydev' }
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          hledger = {
            name = 'hledger',
            module = 'blink.compat.source',
            score_offset = -1,
            opts = {}
          },
          natdat = {
            name = 'natdat',
            module = 'blink.compat.source',
            score_offset = 1,
            opts = {}
          },
          snippets = {
            opts = {
              friendly_snippets = true,
            },
          },
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      }
    },
    opts_extend = {
      "sources.default",
      "sources.completion.enabled_providers",
      "sources.compat",
    }
  }
}
