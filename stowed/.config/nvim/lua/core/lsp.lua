vim.lsp.enable({
  "ast_grep",
  "astro",
  "bacon_ls",
  "clojure_lsp",
  "elixirls",
  "elmls",
  "elp", -- erlang
  "emmet_language_server",
  "eslint",
  "fennel_ls",
  "fish_lsp",
  "gleam",
  "hls",
  "html",
  "janet_lsp",
  "jsonls",
  "leanls",
  "lemminx",
  "ltex_plus",
  "lua_ls",
  "marksman",
  "nil_ls",
  "ocamllsp",
  "odoo_lsp",
  "pylsp",
  "pyright",
  "ruby_lsp",
  "ruff",
  "rust_analyzer",
  "scheme_langserver",
  "syntax_tree",
  "tailwindcss",
  "taplo",
  "tinymist",
  "ts_ls",
  "yamlls",
  "zls",
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = { enable = false },
      diagnostics = { enable = false }, -- disable this when using "bacon_ls" as a diagnostics lsp for rust
      lens = {
        enable = true,
        run = { enable = true },
        implementations = { enable = true },
        references = {
          adt = { enable = true },
          method = { enable = true },
          trait = { enable = true },
          enumVariant = { enable = true },
        },
      },
      typing = {
        tabSize = 2,
        useTab = false,
      },
    }
  }
})
