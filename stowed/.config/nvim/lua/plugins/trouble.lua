return {
  "folke/trouble.nvim",
  lazy = true,
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = {
    "Trouble",
    "TroubleClose",
    "TroubleToggle",
    "TroubleRefresh",
  },
  config = function()
    require("trouble").setup({})
  end
}
