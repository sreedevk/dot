return {
  {
    'L3MON4D3/LuaSnip',
    tag = "v2.3.0",
    build = "make install_jsregexp",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v2.x",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'kirasok/cmp-hledger',
      'neovim/nvim-lspconfig',
      'onsails/lspkind.nvim',
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
    },
    config = function()
      vim.opt.signcolumn = 'yes'
      local cmp = require('cmp')
      local lsp_kind = require('lspkind')
      local lsp_config = require('lspconfig')
      local lsp_config_defaults = lsp_config.util.default_config
      local lsp_on_attach_cb = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
      end

      lsp_config_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_config_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = lsp_on_attach_cb,
      })

      require('mason').setup({})
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })

      lsp_config.gleam.setup {}
      lsp_config.ocamllsp.setup {}
      lsp_config.rust_analyzer.setup {}
      lsp_config.lua_ls.setup {}
      lsp_config.ruby_lsp.setup({
        mason = false,
        cmd = { vim.fn.trim(vim.fn.system("which ruby-lsp")) },
      })

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        experimental = { ghost_text = false },
        formatting = {
          format = lsp_kind.cmp_format({
            mode = 'symbol_text',
            maxwidth = {
              menu = 50,
              abbr = 50
            },
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
          { name = "nvim_lsp", priority = 8, group_index = 2 },
          { name = "luasnip",  priority = 7, group_index = 2 },
          { name = "buffer",   priority = 7, group_index = 2 },
          { name = "path",     priority = 6, group_index = 2 },
          { name = 'hledger',  priority = 5, group_index = 2 }
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      local lsp_zero = require('lsp-zero').preset({})

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        lsp_zero.highlight_symbol(client, bufnr)
        -- NOTE: uncomment to enable autoformat
        -- lsp_zero.buffer_autoformat()
      end)

      lsp_zero.setup()
    end
  }
}
