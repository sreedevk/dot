return {
  {
    "catppuccin/nvim",
    lazy = true,
    enabled = true,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false
    },
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "theamallalgi/zitchdog",
    lazy = false,
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "zitchdog-grape"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        }
      }
    },
    init = function()
      vim.cmd.colorscheme "carbonfox"
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end
  },
  {
    "adibhanna/forest-night.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme "forest-night"
    end
  }
}
