return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<Leader>ol", "<cmd>Outline<CR>", desc = "Toggle Code Outline" },
  },
  opts = {
    outline_window = {
      position = 'right',
      auto_close = false,
      auto_jump = false,
      jump_highlight_duration = 300,
    }
  },
}
