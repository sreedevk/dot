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
        breadcrumb = "»",
        separator = "󱦰 ",
        group = "󰹍 ",
        ellipsis = "…",
        mappings = true,
        colors = true,
      },
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true
        }
      },
    },
  }
}
