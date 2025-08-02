require('core.utils').setup_lsp {
  name = 'elixirls',
  enable = true,
  custom = false,
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
  cmd = { 'elixir-ls' },
  root_markers = { 'mix.exs', '.git' }
}
