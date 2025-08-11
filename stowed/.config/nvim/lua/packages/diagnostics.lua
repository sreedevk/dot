return {
  "rachartier/tiny-inline-diagnostic.nvim",
  enabled = false,
  event = "LspAttach",
  priority = 1000,
  opts = {
    -- Available options:
    -- "modern", "classic", "minimal", "powerline",
    -- "ghost", "simple", "nonerdfont", "amongus"
    preset = "modern",
    transparent_bg = false,
    transparent_cursorline = false,
    options = {
      show_source = {
        enabled = false,
        if_many = false,
      },
    }
  }
}
