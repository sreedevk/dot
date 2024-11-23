return {
  {
    'echasnovski/mini.ai',
    version = '*',
    lazy = true,
    keys = {
      { "vi", mode = "n" },
      { "va", mode = "n" }
    },
    config = function()
      require('mini.ai').setup()
    end
  },

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
