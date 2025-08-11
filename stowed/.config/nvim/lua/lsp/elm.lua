require('core.utils').setup_lsp {
  name = 'elm-language-server',
  enable = true,
  custom = true,
  cmd = { 'elm-language-server' },
  filetypes = { 'elm' },
  root_markers = { 'elm.json', '.git' }
}
