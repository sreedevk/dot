local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

telescope.setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}
telescope.load_extension "file_browser"
