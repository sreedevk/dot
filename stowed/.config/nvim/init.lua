--  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
-- ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
--  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
--   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
--    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
--    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
--    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
--      ░░   ▒ ░░      ░     ░░   ░ ░
--       ░   ░         ░      ░     ░ ░
--      ░                           ░
-- AUTHOR: SREEDEV KODICHATH

require('speed')      -- improve startup performance
require('plugins')    -- installed plugins
require('plugconf')   -- plugin specific configs
require('opts')       -- vim global opts
require('utils')      -- custom util lua functions
require('commands')   -- custom nvim commands
require('keybind')    -- keybindings
require('icons')      -- icons

if vim.g.neovide == true then
  require("neovide")
end
