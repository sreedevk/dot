return {
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    opts = {
      skipInsignificantPunctuation = true,
      subwordMovement = true,
      consistentOperatorPending = false,
      customPatterns = {},
    },
    keys = {
      { "w",  function() require('spider').motion('w') end,  mode = { "n", "o", "x" } },
      { "e",  function() require('spider').motion('e') end,  mode = { "n", "o", "x" } },
      { "b",  function() require('spider').motion('b') end,  mode = { "n", "o", "x" } },
      { "ge", function() require('spider').motion('ge') end, mode = { "n", "o", "x" } },
    },
  },
}
