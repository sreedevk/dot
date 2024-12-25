return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    ft = { "markdown", "lsp_markdown" },
    cmd = { "RenderMarkdown" },
    opts = {
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
  }
}
