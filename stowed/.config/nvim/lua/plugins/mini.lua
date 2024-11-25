return {
  {
    'echasnovski/mini.comment',
    lazy = true,
    keys = {
      { "gcc", mode = "n" },
      { "gc",  mode = "v" }
    },
    config = function()
      require('mini.comment').setup()
    end
  },
}
