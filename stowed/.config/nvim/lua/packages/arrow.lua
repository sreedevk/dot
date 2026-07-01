return {
  "otavioschwanck/arrow.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    show_icons = true,
    leader_key = '\\',
    separate_by_branch = true,
    hide_handbook = true,
    hide_buffer_handbook = false,
    mappings = {
      edit = "e",
      delete_mode = "d",
      clear_all_items = "C",
      toggle = "s",
      open_vertical = "v",
      open_horizontal = "-",
      quit = "q",
      remove = "x",
      next_item = "]",
      prev_item = "["
    },
  }
}
