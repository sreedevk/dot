---@type vim.lsp.Config
return {
  cmd = { 'cthulhu', 'lsp' },

  filetypes = { 'sml' },
  root_markers = {
    '.git',
  },
}
