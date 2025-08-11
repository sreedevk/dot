require('core.utils').setup_lsp {
  name = 'ocamllsp',
  enable = true,
  custom = false,
  filetypes = { 'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune' },
  cmd = { 'ocamllsp', '-stdio' },
  root_markers = {
    'dune-project',
    'dune-workspace',
    'package.json',
    '.git',
    'esy.json',
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
