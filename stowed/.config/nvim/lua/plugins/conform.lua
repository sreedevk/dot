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
          lua = { "stylua", },
          python = { "isort", "black", },
          nix = { "nixpkgs-fmt" },
          javascript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          graphql = { "prettierd", "prettier" },
          md = { "prettierd", "prettier" },
          txt = { "prettierd", "prettier" },
          gleam = {
            "gleam",
            lsp_format = "fallback",
          },
          rust = {
            "rustfmt",
            lsp_format = "fallback",
          },
          ruby = {
            "rubocop",
            "rubyfmt",
            "trim_whitespace",
            lsp_format = "fallback",
          },
        },
        formatters = {
          stylua = {
            args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
          },
          prettier = {
            require_cwd = true,
            cwd = require("conform.util").root_file({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            }),
          },
        },
      })
    end
  }
}
