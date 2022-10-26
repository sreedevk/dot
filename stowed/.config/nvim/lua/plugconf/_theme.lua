local theme_ok, theme = pcall(require, "rose-pine")
if not theme_ok then
  return
end

theme.setup({
  disable_background = true,
})

vim.cmd('colorscheme rose-pine')
