return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    ft = { "markdown", "lsp_markdown" },
    cmd = { "RenderMarkdown" },
    opts = {
      enabled = true,
      code = {
        enabled = true,
        render_modes = false,
        style = 'full',
        disable_background = true,
        width = 'block',
        left_margin = 0.4,
        min_width = 500,
        border = 'thick',
        highlight = 'RenderMarkdownCode',
        highlight_inline = 'RenderMarkdownCodeInline',
        inline_pad = 4,
      },
      file_types = { 'markdown', 'lsp_markdown' },
      render_modes = { 'n', 'c', 't' },
      heading = {
        enabled = true,
        sign = false,
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
  }
}
