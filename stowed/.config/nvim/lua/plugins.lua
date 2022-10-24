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
  use 'wbthomason/packer.nvim' -- plugin manager
  use 'mattn/emmet-vim'        -- html emmets
  use 'hoob3rt/lualine.nvim'   -- statusline
  use 'tpope/vim-fugitive'     -- git
  use 'tpope/vim-rails'        -- rails support
  use 'tpope/vim-surround'     -- ysiw
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use 'Shatur/neovim-ayu'
  use 'dhruvasagar/vim-table-mode'

  -- lsp config (begin)
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  }
  use 'williamboman/mason-lspconfig.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use { "glepnir/lspsaga.nvim", branch = "main" }

  -- lsp config (end)

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

  use 'windwp/nvim-ts-autotag'

  use {
    'kyazdani42/nvim-tree.lua',
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  }

  -- Language Server + Intellisense
  use { 'sheerun/vim-polyglot' }
  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end
  }

  -- Fzf
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim'
    }
  }

  -- EasyMotion
  use {
    'phaazon/hop.nvim', as = 'hop',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use 'christoomey/vim-tmux-navigator'

  if packer_bootstrap then
    require("packer").sync()
  end
end)
