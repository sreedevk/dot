return {
  {
    'stevearc/conform.nvim',
    config = function()
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      vim.keymap.set('n', '<Leader>ff', "<cmd>Format<CR>", { noremap = true })

      require("conform").setup({
        format_on_save = nil,
        formatters_by_ft = {
          lua = {
            "stylua",
          },
          python = {
            "isort",
            "black",
          },
          ruby = {
            "rubocop",
            "rubyfmt",
            "trim_whitespace",
            lsp_format = "fallback",
          },
          nix = {
            "nixpkgs-fmt"
          },
          gleam = {
            "gleam",
            lsp_format = "fallback"
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
