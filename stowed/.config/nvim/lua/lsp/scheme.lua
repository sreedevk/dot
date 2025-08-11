require('core.utils').setup_lsp {
  name = 'scheme-langserver',
  custom = false,
  enable = true,
  filetypes = { 'scheme' },
  cmd = {
    'scheme-langserver',
    '/tmp/scheme-langserver.log',
    --enable multi-thread
    'enable',
    --disable type inference, because it's on very early stage.
    'diable',
  }
}

-- chicken scheme lsp server
-- require('core.utils').setup_lsp {
--   name = 'chicken-scheme-lsp',
--   custom = true,
--   enable = true,
--   filetypes = { 'scheme' },
--   cmd = { 'chicken-lsp-server' },
-- }
