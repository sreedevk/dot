require('core.utils').setup_lsp {
  name = 'hls',
  enable = true,
  custom = false,
  filetypes = { 'haskell', 'lhaskell' },
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  root_markers = { 'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml' },
  settings = {
    haskell = {
      formattingProvider = 'ormolu',
      cabalFormattingProvider = 'cabalfmt',
    },
  },
}
