return {
  {
    'echasnovski/mini.comment',
    lazy = true,
    keys = {
      "gcE",
      { "gc", mode = "v" }
    },
    config = function()
      require('mini.comment').setup()
    end
  },
}
