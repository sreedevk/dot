require('core.utils').setup_lsp {
  name = 'clojure_lsp',
  enable = true,
  custom = false,
  filetypes = { 'clojure', 'edn' },
  cmd = { 'clojure-lsp' },
  root_markers = { 'main.clj', '.git' }
}
