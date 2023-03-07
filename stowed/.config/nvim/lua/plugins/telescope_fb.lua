return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup {
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
          mappings = {
            ["i"] = {},
            ["n"] = {},
          },
        },
      },
    }
    telescope.load_extension "file_browser"
  end
}
