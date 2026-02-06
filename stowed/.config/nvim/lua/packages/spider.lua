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
      { "w",  function() require('spider').motion('w') end,  mode = { "n", "x" } },
      { "e",  function() require('spider').motion('e') end,  mode = { "n", "x" } },
    },
  },
}
