return {
  "max397574/better-escape.nvim",
  main = 'better_escape',
  lazy = true,
  event = { "CursorHold", "CursorHoldI" },
  opts = {
    timeout = 400,
    default_mappings = false,
    mappings = {
      i = {
        j = { j = "<Esc>" }
      },
    },
  },
}
