local language_id_of = {
  menhir = 'ocaml.menhir',
  ocaml = 'ocaml',
  ocamlinterface = 'ocaml.interface',
  ocamllex = 'ocaml.ocamllex',
  reason = 'reason',
  dune = 'dune',
}

require('core.utils').setup_lsp {
  name = 'ocamllsp',
  enable = true,
  custom = false,
  filetypes = {
    'ocaml',
    'menhir',
    'ocamlinterface',
    'ocamllex',
    'reason',
    'dune',
  },
  cmd = { 'ocamllsp', '-stdio' },
  get_language_id = function(_, ftype)
    return language_id_of[ftype]
  end,
  root_markers = {
    'dune-project',
    'dune-workspace',
    'package.json',
    '.git',
    'esy.json',
    '.ocamlformat'
  },
  settings = {
    ['ocamllsp'] = {
      codelens = { enable = true },
      inlayHints = {
        enable = true,
        hintPatternVariables = true,
        hintLetBindings = true,
      },
      extendedHover = { enable = true },
      syntaxDocumentation = { enable = true },
      merlinJumpCodeActions = { enable = true },
      duneDiagnostics = { enable = true },
    }
  }
}
