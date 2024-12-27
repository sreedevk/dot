return {
  {
    'L3MON4D3/LuaSnip',
    tag = "v2.3.0",
    build = "make install_jsregexp",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },

  {
    "Gelio/cmp-natdat",
    config = true,
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v2.x",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      "Gelio/cmp-natdat",
      "hrsh7th/cmp-calc",
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
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Goto Definition" })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = "Goto Declaration" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover" })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = event.buf, desc = "Goto Implementation" })
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = event.buf, desc = "Goto TypeDef" })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = event.buf, desc = "List References" })
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename Variable" })
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Rename Variable" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = event.buf, desc = "Next Diagnostic Msg" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = event.buf, desc = "Prev Diagnostic Msg" })
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,
          { buffer = event.buf, desc = "Find Workspace Symbol" })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Signature Help" })
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = event.buf, desc = "Jump Into Float" })
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
        ensure_installed = {
          "lua_ls",
          "clojure_lsp",
          "docker_compose_language_service",
          "dockerls",
          "elixirls",
          "fennel_ls",
          "jsonls",
          "rnix",
          "rust_analyzer",
          "tailwindcss",
          "taplo",
          "ts_ls",
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })

      lsp_config.gleam.setup {}
      lsp_config.ocamllsp.setup {}
      lsp_config.ruby_lsp.setup({
        mason = false,
        cmd = { vim.fn.trim(vim.fn.system("which ruby-lsp")) },
      })

      require('luasnip.loaders.from_vscode').lazy_load()

      vim.keymap.set('n', "<Leader>ma", "<cmd>Mason<CR>", { desc = "Mason Dashboard", noremap = true })

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
