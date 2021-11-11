## The Dot Project Wiki - Neovim Configuration
The neovim configuration in the dot project is written purely in lua since neovim has a lua runtime baked into it since v0.5.
The `stowed/.config/nvim/init.lua` loads a bunch of lua files each of which configures some aspect of neovim.

### Neovim Configuration Files Structure

```
.
├── init.lua                 --  entry point into the configuration
├── _init.vim                --  alternate vimscript configuration that loads the lua configuration (< v0.5)
├── lua
│   ├── colors.lua           -- coloscheme
│   ├── commands.lua         -- custom nvim commands & command remaps
│   ├── functions.lua        -- lua functions
│   ├── mappings.lua         -- custom key bindings + sane defaults
│   ├── opts.lua             -- plugin + global options
│   ├── plugins.lua          -- packer plugin manager config + plugin specifications
│   ├── status.lua           -- status bar (lualine) configuration
│   └── _telescope.lua       -- Telescope.nvim keybindings + defaults
└── plugin
    └── packer_compiled.lua  -- Compiled plugins
```

### Plugins

1. Packer [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
Lua based package manager

2. Emmet-Vim [mattn/emmet-vim](https://github.com/mattn/emmet-vim)
Abbreviation expansion engine

3. NERDTree [scrooloose/nerdTree](https://github.com/scrooloose/nerdTree)
Filesystem explorer

4. Gundo [sjl/gundo.vim](https://github.com/sjl/gundo.vim)
Undo Tree

5. Vim-Surround [tpope/vim-surround](https://github.com/tpope/vim-surround)
Easy manage wrapping brackets

6. Lualine [hoob3rt/lualine.nvim](https://github.com/hoob3rt/lualine.nvim)
Lua based Status line

7. Vim Fugitive [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
Vim git plugin

8. Vim Smoothie [psliwka/vim-smoothie](https://github.com/psliwka/vim-smoothie)
Smooth Scrolling

9. Ayu Vim [ayu-theme/ayu-vim](https://github.com/ayu-theme/ayu-vim)
Colorscheme

10. Tokyonight [ghifarit53/tokyonight-vim](https://github.com/ghifarit53/tokyonight-vim)
Colorscheme

11. LSP Config [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
LSP Config

12. CoC [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
Code Completion

13. Neovim Treesitter [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
Neovim Treesitter

14. Telescope.nvim [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
Fuzzy Finder

15. Hop.nvim [phaazon/hop.nvim](https://github.com/phaazon/hop.nvim)
Easymotion
