return {
  "EdenEast/nightfox.nvim",
  config = function()
    require('nightfox').setup({
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        colorblind = {
          enable = false,
          simulate_only = false,
          severity = {
            protan = 0,
            deutan = 0,
            tritan = 0,
          },
        },
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          variables = "NONE",
        },
        inverse = {
          match_paren = true,
          visual = true,
          search = true,
        },
        modules = {},
      },
      palettes = {},
      specs = {},
      groups = {},
    })

    vim.cmd([[colorscheme duskfox]])
  end
}
