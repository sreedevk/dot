return {
  {
    "theamallalgi/zitchdog",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme zitchdog-grape]])
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = true,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end
  }
}
