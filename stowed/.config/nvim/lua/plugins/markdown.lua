return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    ft = { "markdown", "lsp_markdown" },
    cmd = { "RenderMarkdown" },
    opts = {
      enabled = true,
      file_types = { 'markdown' },
      render_modes = { 'n', 'c', 't' },
      heading = {
        enabled = true,
        sign = false
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
  }
}
