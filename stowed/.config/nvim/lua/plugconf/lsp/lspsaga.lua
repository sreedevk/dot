local saga_ok, saga = pcall(require, "lspsaga")
if not saga_ok then
  return
end

saga.init_lsp_saga({
  code_action_icon = "",
  code_action_lightbulb = {
    enabled = false,
    enable_in_insert = false,
    sign = false
  },
  finder_icons = {
    def = "∆",
    ref = "∊",
    link = "⍳"
  },
  symbol_in_winbar = {
    enabled = false
  },
  move_in_saga = { prev = "<C-k>", next = "<C-j>" },
  finder_action_keys = {
    open = "<CR>",
  },
  definition_action_keys = {
    edit = "<CR>",
  }
})
