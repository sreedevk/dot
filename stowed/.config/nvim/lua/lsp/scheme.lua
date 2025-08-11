require('core.utils').setup_lsp {
  name = 'scheme-langserver',
  custom = false,
  enable = true,
  filetypes = { 'scheme' },
  cmd = { 'scheme-langserver' }
}

-- chicken scheme lsp server
-- require('core.utils').setup_lsp {
--   name = 'chicken-scheme-lsp',
--   custom = true,
--   enable = true,
--   filetypes = { 'scheme' },
--   cmd = { 'chicken-lsp-server' },
-- }
