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

pcall(require, "impatient")

return packer.startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "mattn/emmet-vim"
    use "hoob3rt/lualine.nvim"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "tpope/vim-rails"
    use "dhruvasagar/vim-table-mode"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-calc"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "windwp/nvim-ts-autotag"
    use "nvim-lua/plenary.nvim"
    use "nathom/filetype.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "nvim-treesitter/nvim-treesitter"
    use "kdheepak/lazygit.nvim"
    use { "rose-pine/neovim", as = "rose-pine" }
    use { "glepnir/lspsaga.nvim", branch = "main" }
    use { "jdhao/better-escape.vim", event = "InsertEnter" }

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

    use { "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
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

    use {
      "echasnovski/mini.indentscope",
      config = function()
        require("mini.indentscope").setup()
      end
    }

    if packer_bootstrap then
      require("packer").sync()
    end
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
