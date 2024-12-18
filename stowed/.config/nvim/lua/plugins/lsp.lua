return {
  {
    'L3MON4D3/LuaSnip',
    tag = "v2.3.0",
    build = "make install_jsregexp"
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v2.x",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      vim.opt.signcolumn = 'yes'
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local lspconfig = require('lspconfig')
      local lspconfig_defaults = lspconfig.util.default_config

      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "K", "<cmd>Lspsaga peek_definition<CR>", opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>rf", "<cmd>Lspsaga lsp_finder<CR>", opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
        end,
      })

      require('mason').setup({})
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })

      lspconfig.gleam.setup {}
      lspconfig.ocamllsp.setup {}
      lspconfig.rust_analyzer.setup {}
      lspconfig.lua_ls.setup {}
      lspconfig.ruby_lsp.setup({
        mason = false,
        cmd = { vim.fn.trim(vim.fn.system("which ruby-lsp")) },
      })

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        experimental = { ghost_text = false },
        formatting = {
          format = lspkind.cmp_format({
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
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 8, group_index = 2 },
          { name = "luasnip",  priority = 7, group_index = 2 },
          { name = "buffer",   priority = 7, group_index = 2 },
          { name = "path",     priority = 6, group_index = 2 }
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
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
