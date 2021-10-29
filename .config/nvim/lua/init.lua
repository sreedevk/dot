require('plugins')

-- LOAD COLORSCHEME
-- ayucolor = light / mirage / dark
vim.g['ayucolor'] = 'dark'
vim.cmd 'colorscheme ayu' 

-- PLUGINS AND OPTIONS
require('_telescope')
require('status')
require('opts')
require('mappings')
