---@type vim.lsp.Config
return {
  cmd = { 'lean', '--server' },
  filetypes = { 'lean' },
  root_markers = { 'lakefile.lean', 'lakefile.toml', 'lean-toolchain', '.git' },
  settings = {
    lean = {
      editDelay = 200,
    },
  },
}
