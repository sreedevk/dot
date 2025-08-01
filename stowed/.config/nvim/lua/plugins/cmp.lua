return {
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "Gelio/cmp-natdat",
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'kirasok/cmp-hledger',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require("cmp")
      local lsp_kind = require('lspkind')

      cmp.setup({
        filetype = {
          ["sql"] = {
            sources = {
              { name = "vim-dadbod-completion" }
            },
          }
        },
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
        completion = { completeopt = "menu,menuone" },
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
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', { capabilities = cmp_capabilities })
    end
  },
  {
    "Gelio/cmp-natdat",
    config = true,
    lazy = true,
  },
}
