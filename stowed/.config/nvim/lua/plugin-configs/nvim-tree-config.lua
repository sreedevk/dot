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
  renderer = {
    group_empty = false,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false,
  },
  create_in_closed_folder = true,
  prefer_startup_root = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
}
