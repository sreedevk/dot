return {
  {
    'echasnovski/mini.comment',
    lazy = true,
    keys = {
      { "gcc", mode = "n" },
      { "gc",  mode = "v" }
    },
    config = true
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
}
