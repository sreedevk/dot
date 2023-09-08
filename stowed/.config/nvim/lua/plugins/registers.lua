return {
  "tversteeg/registers.nvim",
  name = "registers",
  keys = {
    { "\"",    mode = { "n", "v" } },
    { "<C-R>", mode = "i" }
  },
  config =
      function()
        require('registers').setup()
      end,
  cmd = "Registers",
}
