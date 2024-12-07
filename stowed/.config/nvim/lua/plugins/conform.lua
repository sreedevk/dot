return {
  {
    'stevearc/conform.nvim',
    config = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = {
            "stylua",
          },
          python = {
            "isort",
            "black",
          },
          ruby = {
            "trim_whitespace",
            lsp_format = "first",
          },
          nix = {
            "nixpkgs-fmt"
          },
          rust = {
            "rustfmt",
            lsp_format = "fallback",
          },
          javascript = {
            "prettierd",
            "prettier",
            stop_after_first = true,
          },
        },
      })
    end
  }
}
