return {
  {
    'stevearc/conform.nvim',
    config = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      require("conform").setup({
        format_on_save = {
          -- These options will be passed to conform.format()
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
