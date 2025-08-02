require('core.utils').setup_lsp {
  name = 'jsonnet_ls',
  enable = false,
  custom = false,
  cmd = { 'jsonnet-language-server' },
  filetypes = { 'jsonet' },
  settings = {
    ['jsonnet_ls'] = {
      ext_vars = { foo = 'bar' },
      formatting = {
        Indent              = 2,
        MaxBlankLines       = 2,
        StringStyle         = 'double',
        CommentStyle        = 'slash',
        PrettyFieldNames    = true,
        PadArrays           = true,
        PadObjects          = true,
        SortImports         = true,
        UseImplicitPlus     = true,
        StripEverything     = false,
        StripComments       = false,
        StripAllButComments = false,
      },
    }
  }
}
