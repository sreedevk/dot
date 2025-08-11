return {
  "tversteeg/registers.nvim",
  name = "registers",
  cmd = "Registers",
  keys = {
    { "\"",    mode = { "n", "v" } },
    { "<C-R>", mode = "i" }
  },
  opts = {
    show = "*+\"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz:",
    show_empty = false,
    register_user_command = true,
    system_clipboard = true,
    trim_whitespace = true,
    hide_only_whitespace = true,
    show_register_types = true
  }
}
