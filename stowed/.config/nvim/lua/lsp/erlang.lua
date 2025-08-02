require('core.utils').setup_lsp {
  name = 'erlangls',
  enable = true,
  custom = false,
  filetypes = { 'erlang' },
  cmd = { 'erlang_ls' },
  root_markers = { '.git', 'rebar.config', 'erlang.mk' }
}
