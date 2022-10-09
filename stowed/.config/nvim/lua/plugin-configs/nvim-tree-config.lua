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
      quit_on_open = false
    }
  },
  renderer = {
    group_empty = false,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  create_in_closed_folder = true,
  prefer_startup_root = true,
  sync_root_with_cwd = true,
  hijack_cursor = true,
  respect_buf_cwd = false,
}
