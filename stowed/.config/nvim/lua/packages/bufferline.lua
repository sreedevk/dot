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
      show_tab_indicators = true,
      duplicates_across_groups = false,
      separator_style = "slope", -- "slant" | "slope" | "thick" | "thin"
      always_show_bufferline = false,
      auto_toggle_bufferline = true,
      hover = {
        enabled = false,
        delay = 200,
        reveal = { 'close' }
      },
    },
  }
}
