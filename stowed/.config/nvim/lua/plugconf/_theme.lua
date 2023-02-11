local theme_ok, theme = pcall(require, 'nightfox')
if not theme_ok then
  return
end

theme.setup({
  options = {
    transparent = true,
  }
})

vim.cmd('colorscheme terafox')
