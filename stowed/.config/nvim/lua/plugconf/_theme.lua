local theme_ok, theme = pcall(require, 'nightfox')
if not theme_ok then
  return
end

theme.setup({
  options = {
    transparent = false,
  }
})

vim.cmd('colorscheme terafox')
