require('core.utils').setup_lsp {
  name = 'zls',
  enable = true,
  custom = false,
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' }
}
