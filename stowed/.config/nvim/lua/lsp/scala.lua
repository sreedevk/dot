require('core.utils').setup_lsp {
  name = 'metals',
  enable = false,
  custom = true,
  filetypes = { 'scala', 'sbt', 'java' },
  cmd = { 'metals', '--stdio' },
  root_markers = { '.scala-build', 'build.sbt', 'build.sc', '.git', '.scala' },
  init_options = {
    compilerOptions = {},
    -- debuggingProvider = true,
    -- testExplorerProvider = true,
    -- disableColorOutput = true,
    -- doctorProvider = "json",
    -- doctorVisibilityProvider = true,
    -- executeClientCommandProvider = true,
    -- inputBoxProvider = true,
    -- quickPickProvider = true,
    -- statusBarProvider = "show-message",
    -- bspStatusBarProvider = "on",
    -- treeViewProvider = true
  }
}
