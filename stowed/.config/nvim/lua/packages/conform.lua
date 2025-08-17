return {
  "stevearc/conform.nvim",
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    formatters_by_ft = {
      ocaml = { "ocamlformat" },
      ruby = { "rubyfmt" },
      dockerfile = { "dockfmt" },
      nim = { "nph" }
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
      dockfmt = { "dockfmt" },
      rubyfmt = { "rubyfmt" },
      nph = { "nph" },
      rust = { "rustfmt" },
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
