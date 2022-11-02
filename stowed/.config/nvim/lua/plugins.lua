local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'mattn/emmet-vim'
  use 'hoob3rt/lualine.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-obsession'
  use 'tpope/vim-rails'
  use 'tpope/vim-dadbod'
  use 'dhruvasagar/vim-table-mode'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'rafcamlet/nvim-luapad'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'windwp/nvim-ts-autotag'
  use 'christoomey/vim-tmux-navigator'

  use { 'echasnovski/mini.nvim', branch = 'stable' }
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use { 'kyazdani42/nvim-tree.lua', tag = 'nightly', }

  use { 'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = false,
      }
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        map_cr = false
      }
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end
  }

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim'
    }
  }

  use {
    'phaazon/hop.nvim', as = 'hop',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
