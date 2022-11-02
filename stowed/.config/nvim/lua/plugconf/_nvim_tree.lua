local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

nvim_tree.setup {
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "T", action = "tabnew" },
        { key = "<C-t>", action = "" }
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  renderer = {
    group_empty = false,
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true
      }
    }
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  create_in_closed_folder = true,
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  hijack_cursor = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = false,
    update_root = false
  }
}
