return {
  "j-hui/fidget.nvim",
  lazy = true,
  tag = 'v1.0.0',
  event = "BufReadPost",
  cmd = { "Fidget" },
  opts = {
    progress = {
      display = {
        render_limit = 4,
        done_ttl = 2,
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
        max_width = 400,
        zindex = 1,
      },
    },
  },
}
