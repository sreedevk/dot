return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      themable = true,
      numbers = "buffer_id", -- "none" | "ordinal" | "buffer_id" | "both"
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      duplicates_across_groups = false,
      separator_style = "thin", -- "slant" | "slope" | "thick" | "thin"
      always_show_bufferline = true,
      auto_toggle_bufferline = true,
      hover = {
        enabled = false,
        delay = 200,
        reveal = { 'close' }
      },
    },
  }
}
