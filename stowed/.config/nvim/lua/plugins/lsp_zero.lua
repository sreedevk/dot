return {
  'VonHeikemen/lsp-zero.nvim',
  branch = "v2.x",
  dependencies = {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" }
      }),
    })

    local lsp_zero = require("lsp-zero").preset({})
    lsp_zero.on_attach(function(_client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
    end)

    require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())
    lsp_zero.setup()
  end
}
