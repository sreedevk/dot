local function generate_config(conf)
  return {
    cmd = conf.cmd,
    filetypes = conf.filetypes,
    root_markers = conf.root_markers or { ".git" },
    single_file_support = conf.single_file_support or true,
    init_options = conf.init_options or {},
    settings = conf.settings or {},
  }
end

local function setup_lsp(conf)
  if conf.enable then
    vim.lsp.config[conf.name] = generate_config(conf)
    vim.lsp.enable(conf.name)
  end
end

setup_lsp { -- lua
  name = 'lua_ls',
  enable = true,
  custom = false,
  cmd = { vim.fn.trim(vim.fn.system("which lua-language-server")) },
  filetypes = { "lua" },
}

setup_lsp { -- zig
  name = 'zls',
  enable = true,
  custom = false,
  cmd = { vim.fn.trim(vim.fn.system("which zls")) },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' }
}

setup_lsp { --python
  name = 'pylsp',
  enable = true,
  custom = false,
  cmd = { vim.fn.trim(vim.fn.system("which pylsp")) },
  filetypes = { "python" },
  root_markers = {
    '.git',
    'Pipfile',
    'pyproject.toml',
    'requirements.txt',
    'setup.cfg',
    'setup.py',
    'uv.lock',
  },
}

setup_lsp { -- json
  name = "jsonnet_ls",
  enable = false,
  custom = false,
  cmd = { vim.fn.trim(vim.fn.system("which jsonnet-language-server")) },
  filetypes = { "json" },
  settings = {
    ["jsonnet_ls"] = {
      ext_vars = { foo = 'bar' },
      formatting = {
        Indent              = 2,
        MaxBlankLines       = 2,
        StringStyle         = 'double',
        CommentStyle        = 'slash',
        PrettyFieldNames    = false,
        PadArrays           = false,
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

setup_lsp { -- janet
  name = 'janet-lsp',
  enable = true,
  custom = true,
  filetypes = { 'janet' },
  cmd = { vim.fn.trim(vim.fn.system("which janet-lsp")) },
  root_markers = { 'project.janet', '.git' }
}

setup_lsp { -- lean
  name = "leanls",
  enable = true,
  custom = false,
  filetypes = { "lean" },
  cmd = { vim.fn.trim(vim.fn.system("which lean")), "--server" },
  root_markers = { '.git', 'leanpkg.toml' }
}

setup_lsp { -- elm
  name = 'elm-language-server',
  enable = true,
  custom = true,
  cmd = { vim.fn.trim(vim.fn.system("which elm-language-server")) },
  filetypes = { 'elm' },
  root_markers = { 'elm.json', '.git' }
}

setup_lsp { -- nim
  name = 'nim_langserver',
  enable = true,
  custom = false,
  cmd = { vim.fn.trim(vim.fn.system("which nimlangserver")) },
  filetypes = { 'nim' },
  root_markers = { '.git' }
}

setup_lsp { -- gleam
  name = 'gleam',
  enable = true,
  custom = false,
  filetypes = { "gleam" },
  cmd = { vim.fn.trim(vim.fn.system("which gleam")), "lsp" },
  root_markers = { 'gleam.toml', '.git' }
}

setup_lsp { -- ruby
  name = 'ruby_lsp',
  enable = true,
  custom = false,
  filetypes = { 'ruby', 'eruby' },
  cmd = { vim.fn.trim(vim.fn.system("which ruby-lsp")) },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'auto',
    linters = { 'standard' },
    experimentalFeaturesEnabled = true,
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      formatting = true,
      diagnostics = true,
      definition = true,
      hover = true,
      inlayHints = true,
      onTypeFormatting = true,
      selectionRanges = true,
      semanticHighlighting = true,
    },
  },
}

setup_lsp { -- ocaml
  name = "ocamllsp",
  enable = true,
  custom = false,
  filetypes = { 'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune' },
  cmd = { vim.fn.trim(vim.fn.system("which ocamllsp")), "-stdio" },
  root_markers = {
    'dune-project',
    'dune-workspace',
    'package.json',
    '.git',
    'esy.json',
  },
  settings = {
    ["ocamllsp"] = {
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

setup_lsp { -- clojure
  name = 'clojure_lsp',
  enable = true,
  custom = false,
  filetypes = { 'clojure', 'edn' },
  cmd = { vim.fn.trim(vim.fn.system("which clojure-lsp")) },
  root_markers = { "main.clj", ".git" }
}

setup_lsp { -- elixir
  name = 'elixirls',
  enable = true,
  custom = false,
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  cmd = { vim.fn.trim(vim.fn.system("which elixir-ls")) },
  root_markers = { 'mix.exs', '.git' }
}

setup_lsp { -- fennel
  name = 'fennel_language_server',
  enable = true,
  custom = false,
  filetypes = { 'fennel' },
  cmd = { vim.fn.trim(vim.fn.system("which fennel-ls")) },
}

setup_lsp { -- yaml
  name = 'yamlls',
  enable = true,
  custom = false,
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  cmd = { vim.fn.trim(vim.fn.system("which yaml-language-server")), "--stdio" },
}

setup_lsp { -- nix
  name = 'nil_ls',
  enable = true,
  custom = false,
  filetypes = { 'nix' },
  cmd = { vim.fn.trim(vim.fn.system("which nil")) },
  root_markers = { 'flake.nix', 'flake.lock' },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  }
}

setup_lsp { -- chicken scheme
  name = 'chicken-scheme-lsp',
  custom = true,
  enable = true,
  filetypes = { 'scheme' },
  cmd = { vim.fn.trim(vim.fn.system("which chicken-lsp-server")) },
}

setup_lsp { -- rust
  name = 'rust_analyzer',
  enable = true,
  custom = false,
  filetypes = { 'rust' },
  cmd = { vim.fn.trim(vim.fn.system("which rust-analyzer")) },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { enable = false },
      diagnostics = { enable = false },
      imports = {
        granularity = { group = "module" },
        prefix = "self",
      },
      cargo = {
        buildScripts = { enable = true },
      },
      procMacro = { enable = true },
    }
  }
}

setup_lsp { -- rust
  name = 'bacon_ls',
  enable = true,
  custom = false,
  filetypes = { 'rust' },
  cmd = { vim.fn.trim(vim.fn.system("which bacon-ls")) },
  root_markers = { '.bacon-locations', 'Cargo.toml', 'Cargo.lock' },
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 1000,
    updateOnChange = false,
  }
}

setup_lsp { -- tailwind
  name = 'tailwindcss',
  enable = true,
  custom = false,
  filetypes = { 'html', 'jsx', 'htmx', 'css', 'scss', 'js', 'ts' },
  cmd = { vim.fn.trim(vim.fn.system("which bun")), "x", "@tailwindcss/language-server", "--stdio" },
  root_markers = { 'package.json', 'yarn.lock', 'bun.lock', 'package.lock' }
}

setup_lsp { -- toml
  name = 'taplo',
  enable = true,
  custom = false,
  filetypes = { 'toml' },
  cmd = { vim.fn.trim(vim.fn.system("which taplo")), "lsp", "stdio" },
}

setup_lsp { -- markdown
  name = 'marksman',
  enable = true,
  custom = false,
  filetypes = { 'markdown', 'markdown.mdx' },
  cmd = { vim.fn.trim(vim.fn.system("which marksman")), "server" }
}

setup_lsp { -- typescript
  name = 'ts_ls',
  enable = true,
  custom = false,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { vim.fn.trim(vim.fn.system("which bun")), "x", "typescript-language-server", "--stdio" },
  root_markers = { 'package.json', 'yarn.lock', 'bun.lock' },
  init_options = {
    hostInfo = "neovim"
  }
}

setup_lsp { --haskell
  name = 'hls',
  enable = true,
  custom = false,
  filetypes = { 'haskell', 'lhaskell' },
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  root_markers = { 'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml' },
  settings = {
    haskell = {
      formattingProvider = 'ormolu',
      cabalFormattingProvider = 'cabalfmt',
    },
  },
}

setup_lsp { -- scala
  name = 'metals',
  enable = false,
  custom = true,
  filetypes = { 'scala', 'sbt', 'java' },
  cmd = { vim.fn.trim(vim.fn.system("which metals")), "--stdio" },
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

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Configurations on LSP Attach",
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end


    vim.opt.signcolumn = 'yes'
    vim.bo[event.buf].formatexpr = nil
    vim.bo[event.buf].omnifunc = nil

    vim.diagnostic.config {
      virtual_lines = { current_line = true },
      virtual_text = { current_line = true }
    }

    local format_buf_async = function()
      vim.lsp.buf.format({ async = true })
    end

    vim.keymap.set('n', '<Leader>ff', format_buf_async, { noremap = true })
    vim.keymap.set({ "n", "v" }, "<Leader>ff", vim.lsp.buf.format, { noremap = true, desc = "LSP Format" })

    -- grn        : rename
    -- grr        : references
    -- gri        : goto implementation
    -- g0         : document symbol
    -- gra        : code action
    -- CTRL-S     : signature help
    -- [d and ]d  : jump b/w diagnostics
    -- [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
    -- [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location list
    -- [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag matchlist
    -- [a, ]a, [A, ]A navigate through the argument list
    -- [b, ]b, [B, ]B navigate through the buffer list
    -- [<Space>, ]<Space> add an empty line above and below the cursor
  end
})
