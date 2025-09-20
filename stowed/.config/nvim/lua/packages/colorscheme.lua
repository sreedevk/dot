return {
  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    enabled = true,
    priority = 1000,
    opts = {
      highlight_groups = {
        TelescopeBorder         = { fg = "overlay", bg = "overlay"        },
        TelescopeNormal         = { fg = "subtle",  bg = "overlay"        },
        TelescopeSelection      = { fg = "text",    bg = "highlight_med"  },
        TelescopeSelectionCaret = { fg = "love",    bg = "highlight_med"  },
        TelescopeMultiSelection = { fg = "text",    bg = "highlight_high" },
        TelescopeTitle          = { fg = "base",    bg = "love"           },
        TelescopePromptTitle    = { fg = "base",    bg = "pine"           },
        TelescopePreviewTitle   = { fg = "base",    bg = "iris"           },
        TelescopePromptNormal   = { fg = "text",    bg = "surface"        },
        TelescopePromptBorder   = { fg = "surface", bg = "surface"        },
      },
      variant = "main",      -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
    },
    init = function()
      vim.cmd.colorscheme "rose-pine"
    end
  },
  {
    "catppuccin/nvim",
    lazy = true,
    enabled = false,
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
    lazy = true,
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "zitchdog-grape"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
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
    lazy = true,
    enabled = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end
  },
  {
    "adibhanna/forest-night.nvim",
    lazy = true,
    enabled = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme "forest-night"
    end
  }
}
