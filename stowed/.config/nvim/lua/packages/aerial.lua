return {
  'stevearc/aerial.nvim',
  keys = {
    { "<Leader>cv", "<cmd>AerialToggle!<CR>", desc = "Aerial Toggle (Code Overview)" }
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
    layout = {
      max_width = { 40, 0.2 },
      width = nil,
      min_width = 0.1,
      win_opts = {},
      default_direction = "prefer_right",
      placement = "window",
      resize_to_content = true,
      preserve_equality = false,
    },
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  }
}
