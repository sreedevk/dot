return {
  "stevearc/conform.nvim",
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    formatters_by_ft = {
      ocaml = { "ocamlformat" },
      ruby = { "rubyfmt" }
    },
    formatters = {
      rubyfmt = {
        "rubyfmt",
        lsp_format = "fallback",
      },
      rust = {
        "rustfmt",
        lsp_format = "fallback",
      },
      ocamlformat = {
        prepend_args = {
          "--if-then-else",
          "vertical",
          "--break-cases",
          "fit-or-vertical",
          "--type-decl",
          "sparse",
        },
      },
    },
  },
}
