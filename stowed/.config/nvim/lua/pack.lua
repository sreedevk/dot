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

require('lazy').setup({ import = 'plugins' }, {
  change_detection = {
    notify = false,
  },
  ui = {
    border = "single"
  },
  performance = {
    cache = { enabled = false },
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
