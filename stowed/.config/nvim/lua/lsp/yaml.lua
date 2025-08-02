require('core.utils').setup_lsp {
  name = 'yamlls',
  enable = true,
  custom = false,
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  cmd = { 'yaml-language-server', '--stdio' },
}
