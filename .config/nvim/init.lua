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

require('plugins')

-- LOAD COLORSCHEME
-- ayucolor = light / mirage / dark
vim.g['ayucolor'] = 'dark'
vim.cmd 'colorscheme ayu' 

-- PLUGINS, OPTIONS & CUSTOM COMMANDS
require('_telescope')
require('status')
require('opts')
require('mappings')
require('commands')
require('functions')
