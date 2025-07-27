return {
  "j-hui/fidget.nvim",
  lazy = true,
  tag = 'v1.0.0',
  event = "BufReadPost",
  opts = {
    progress = {
      display = {
        render_limit = 4,
      },
      lsp = {
        progress_ringbuf_size = 8,
      },
    },
    notification = {
      view = {
        stack_upwards = false,
      },
      window = {
        winblend = 0,
      },
    },
  },
}
