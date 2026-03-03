return {
  {
    "catppuccin/nvim",
    lazy = false,
    enabled = true,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      auto_integrations = true,
      default_integrations = true,
      integrations = {
        blink_cmp = {
          style = 'bordered',
        },
        diffview = true,
        gitsigns = true,
        lualine = true,
        neogit = true,
        overseer = true,
        telescope = true,
        lsp_trouble = true,
        which_key = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "theamallalgi/zitchdog",
    lazy = true,
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "zitchdog-grape"
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    enabled = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end
  }
}
