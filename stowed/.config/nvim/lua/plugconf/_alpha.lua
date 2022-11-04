local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
  return
end

local alpha_theme_ok, alpha_theme = pcall(require, "alpha.themes.theta")
if not alpha_theme_ok then
  return
end

alpha.setup(alpha_theme.config)
