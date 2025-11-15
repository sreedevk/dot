local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ import = 'packages' }, {
  change_detection = {
    notify = false,
  },
  ui = {
    border = "none",
    pills = true,
  },
  rocks = {
    enabled = true,
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://lumen-oss.github.io/rocks-binaries/",
    -- use hererocks to install luarocks?
    -- set to `nil` to use hererocks when luarocks is not found
    -- set to `true` to always use hererocks
    -- set to `false` to always use luarocks
    hererocks = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      }
    }
  },
  dev = {
    path = "~/Data/repositories/neovim/",
    fallback = false
  },
})

vim.keymap.set(
  'n',
  '<Leader>lz',
  '<cmd>Lazy<CR>',
  {
    desc = "Lazy Dashboard",
    noremap = true,
  }
)

vim.cmd.packadd "termdebug"
vim.cmd.packadd "cfilter"
