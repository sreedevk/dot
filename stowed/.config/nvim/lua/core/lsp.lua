vim.lsp.enable({
  "lua_ls", "astro", "clojure_lsp", "tailwindcss", "elixirls", "elmls", "erlangls", "eslint",
  "fennel_ls", "gleam", "hls", "html", "janet_lsp", "jsonls", "jsonnet_ls", "ltex_plus", "marksman",
  "nimls", "nil_ls", "ocamllsp", "pylsp", "ruby_lsp", "rust_analyzer", "bacon_ls", "metals",
  "scheme_langserver", "taplo", "ts_ls", "tinymist", "yamlls", "zls"
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
})
