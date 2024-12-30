return {
  {
    'hrsh7th/nvim-cmp',
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    lazy = true,
    dependencies = {
      'onsails/lspkind.nvim',
      'L3MON4D3/LuaSnip',
      "Gelio/cmp-natdat",
      "hrsh7th/cmp-calc",
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'kirasok/cmp-hledger',
    },
    config = function()
      local cmp = require("cmp")
      local lsp_kind = require('lspkind')
      cmp.setup({
        experimental = { ghost_text = false },
        formatting = {
          expandable_indicator = false,
          fields = { 'menu', 'abbr', 'kind' },
          format = lsp_kind.cmp_format({
            mode = 'symbol_text',
            maxwidth = {
              menu = 50,
              abbr = 50
            },
            ellipsis_char = '...',
            show_labelDetails = true
          }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp",        priority = 8, group_index = 2 },
          { name = "luasnip",         priority = 7, group_index = 2 },
          { name = "buffer",          priority = 7, group_index = 2 },
          { name = "path",            priority = 6, group_index = 2 },
          { name = 'hledger',         priority = 5, group_index = 2 },
          { name = 'render-markdown', priority = 5, group_index = 2 },
          { name = "natdat",          priority = 5, group_index = 2 },
          { name = "calc",            priority = 4, group_index = 3 },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      require('luasnip.loaders.from_vscode').lazy_load()
    end
  },
  {
    'L3MON4D3/LuaSnip',
    tag = "v2.3.0",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = { "rafamadriz/friendly-snippets" },
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },

  {
    "Gelio/cmp-natdat",
    config = true,
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
}
