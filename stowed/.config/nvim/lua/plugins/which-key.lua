return {
  {
    "folke/which-key.nvim",
    enabled = true,
    opts = {
      preset = "helix",
      delay = 0,
      win = {
        height = {
          max = math.huge,
        },
      },
      icons = {
        rules = false,
        breadcrumb = " ",
        separator = "󱦰  ",
        group = "󰹍 ",
      },
      plugins = {
        spelling = {
          enabled = false,
        },
      },
    },
  }
}
