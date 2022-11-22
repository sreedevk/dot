local packer_status, packer = pcall(require, "packer")
if not packer_status then
  return
end

return packer.startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "mattn/emmet-vim"
    use "hoob3rt/lualine.nvim"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "tpope/vim-rails"
    use "vim-ruby/vim-ruby"
    use "dhruvasagar/vim-table-mode"
    use "windwp/nvim-ts-autotag"
    use "nvim-lua/plenary.nvim"
    use "nathom/filetype.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use "kdheepak/lazygit.nvim"
    use "fedepujol/move.nvim"
    use "mbbill/undotree"
    use { "rose-pine/neovim", as = "rose-pine" }
    use { "glepnir/lspsaga.nvim", branch = "main" }
    use { "jdhao/better-escape.vim", event = "InsertEnter" }

    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-calc" },

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
      }
    }

    use {
      "stevearc/aerial.nvim",
      config = function()
        require('aerial').setup()
      end
    }

    use {
      "ggandor/leap.nvim",
      config = function()
        require('leap').add_default_mappings()
      end
    }

    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      }
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup {
          check_ts = true,
          map_cr = false
        }
      end
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-project.nvim'
      }
    }

    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" }
    }

    use {
      "akinsho/toggleterm.nvim",
      tag = '*',
      config = function()
        require("toggleterm").setup()
      end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup()
      end
    }

    use {
      "echasnovski/mini.comment",
      config = function()
        require("mini.comment").setup()
      end
    }

  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
}
)
