require('core.utils').setup_lsp {
  name = 'lua_ls',
  enable = true,
  custom = false,
  cmd = { 'lua-language-server' },
  filetypes = { "lua" },
}
