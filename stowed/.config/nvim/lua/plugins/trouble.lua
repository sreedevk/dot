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
  keys = { "<Leader>tt" },
  config = function()
    require("trouble").setup({ icons = false })

    vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>TroubleToggle quickfix<CR>', { noremap = true })
  end
}
