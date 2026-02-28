return {
  {
    'echasnovski/mini.comment',
    lazy = true,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
          enable_autocmd = false,
        },
      },
    },
    keys = {
      { "gcc", mode = "n", desc = "comment out line" },
      { "gc",  mode = "v", desc = "comment out" }
    },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    }
  },
  {
    "echasnovski/mini.move",
    lazy = true,
    keys = {
      { mode = { "v", "n" }, "<M-h>" },
      { mode = { "v", "n" }, "<M-j>" },
      { mode = { "v", "n" }, "<M-k>" },
      { mode = { "v", "n" }, "<M-l>" }
    },
    opts = {
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      }
    },
    config = true,
    version = false,
  },
  {
    'nvim-mini/mini.cmdline',
    version = '*',
    opts = {
      autocomplete = {
        enable = true,
        delay = 0,
        predicate = nil,
        map_arrows = true,
      },

      autocorrect = {
        enable = false,
        func = nil,
      },

      autopeek = {
        enable = true,
        n_context = 1,
        predicate = nil,
        window = {
          config = {},
          statuscolumn = nil,
        },
      },
    }
  },
}
