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

setup_lsp { -- json
  name = "jsonnet_ls",
  enable = true,
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
      hover = true
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

setup_lsp { -- docker-compose
  name = 'docker_compose_language_service',
  enable = true,
  custom = false,
  filetypes = { 'docker-compose', 'yaml.docker-compose' },
  cmd = { vim.fn.trim(vim.fn.system("which docker-compose-langserver")), "--stdio" },
}

setup_lsp { -- dockerfile
  name = 'dockerls',
  enable = true,
  custom = false,
  filetypes = { 'dockerfile' },
  cmd = { vim.fn.trim(vim.fn.system("which docker-langserver")), "--stdio" },
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

setup_lsp { -- json
  name = "jsonls",
  enable = true,
  custom = false,
  filetypes = { "json", "jsonc" },
  cmd = { vim.fn.trim(vim.fn.system("which vscode-json-languageserver")), "--stdio" },
  init_options = {
    provideFormatter = true
  },
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

setup_lsp {
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
  filetypes = { 'html', 'jsx', 'htmx', 'css', 'scss' },
  cmd = { vim.fn.trim(vim.fn.system("which tailwindcss-language-server")), "--stdio" },
  root_markers = { 'package.json', 'yarn.lock', 'package.lock' }
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

setup_lsp { -- racket
  name = 'raket_langserver',
  enable = true,
  custom = false,
  filetypes = { 'racket' },
  cmd = { vim.fn.trim(vim.fn.system("which racket")), "-l", "racket-langserver" }
}

setup_lsp { -- typescript
  name = 'ts_ls',
  enable = true,
  custom = false,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { vim.fn.trim(vim.fn.system("which typescript-language-server")), "--stdio" },
  root_markers = { 'package.json', 'yarn.lock', 'package.lock' },
  init_options = {
    hostInfo = "neovim"
  }
}

setup_lsp { -- scala
  name = 'metals',
  enable = true,
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
    vim.opt.signcolumn = 'yes'

    vim.bo[event.buf].formatexpr = nil
    vim.bo[event.buf].omnifunc = nil

    local lsp_buf = vim.lsp.buf
    local keymap_opts = function(ev, desc)
      return { buffer = ev.buf, desc = desc }
    end

    local format_buf_async = function()
      vim.lsp.buf.format({ async = true })
    end

    local function vim_diag_next()
      vim.diagnostic.jump({ count = 1, float = true })
    end

    local function vim_diag_prev()
      vim.diagnostic.jump({ count = -1, float = true })
    end

    vim.keymap.set("n", "]d", vim_diag_next, keymap_opts(event, "Next Diagnostic Message"))
    vim.keymap.set("n", "[d", vim_diag_prev, keymap_opts(event, "Previous Diagnostic Message"))
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, keymap_opts(event, "Enter Float"))
    vim.keymap.set("n", "gd", lsp_buf.definition, keymap_opts(event, "Goto Definition"))
    vim.keymap.set('n', 'gD', lsp_buf.declaration, keymap_opts(event, "Goto Declaration"))
    vim.keymap.set('n', 'K', lsp_buf.hover, keymap_opts(event, "Hover"))
    vim.keymap.set('n', 'gi', lsp_buf.implementation, keymap_opts(event, "Goto Implementation"))
    vim.keymap.set('n', 'go', lsp_buf.type_definition, keymap_opts(event, "Goto TypeDef"))
    vim.keymap.set('n', 'gr', lsp_buf.references, keymap_opts(event, "List References"))
    vim.keymap.set('n', '<leader>vrn', lsp_buf.rename, keymap_opts(event, "Rename Variable"))
    vim.keymap.set("n", "<leader>vca", lsp_buf.code_action, keymap_opts(event, "Code Action"))
    vim.keymap.set("n", "<leader>vws", lsp_buf.workspace_symbol, keymap_opts(event, "Find Workspace Symbol"))
    vim.keymap.set("i", "<C-h>", lsp_buf.signature_help, keymap_opts(event, "Signature Help"))
    vim.keymap.set('n', '<Leader>ff', format_buf_async, { noremap = true })
    vim.keymap.set({ "n", "v" }, "<Leader>ff", vim.lsp.buf.format, { noremap = true, desc = "LSP Format" })
  end
})
