return {
  'VonHeikemen/lsp-zero.nvim',
  branch = "v2.x",
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'onsails/lspkind.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'ray-x/cmp-treesitter',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    {
      'glepnir/lspsaga.nvim',
      cmd = "Lspsaga",
      dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" }
      },
      config = function()
        require("lspsaga").setup({
          symbol_in_winbar = {
            enable = true,
            separator = "  ",
            ignore_patterns={},
            hide_keyword = true,
            show_file = true,
            folder_level = 2,
            respect_root = false,
            color_mode = true,
          },
          lightbulb = {
            enable = false,
            enable_in_insert = false,
            sign = false,
            sign_priority = 40,
            virtual_text = false,
          },
        })
      end,
    }
  },
  config = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup({
      experimental = {
        ghost_text = true
      },
      formatting = {
        format = lspkind.cmp_format(),
      },
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
        { name = "nvim_lsp", priority = 8 },
        { name = "luasnip",  priority = 7 },
        { name = "buffer",   priority = 7 },
        { name = "path",     priority = 6 }
      }),
    })

    local lsp = require('lsp-zero').preset({})
    lsp.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", "<cmd>Lspsaga peek_definition<CR>", opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>rf", "<cmd>Lspsaga lsp_finder<CR>", opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      -- Diagonstics
      vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set('n', '<Leader>ff', function() vim.lsp.buf.format({ async = true }) end, opts)
    end)

    lsp.setup()
  end
}
