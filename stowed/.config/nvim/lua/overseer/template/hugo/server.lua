local overseer = require 'overseer'

return {
  name = 'Hugo Server',
  builder = function()
    return {
      cmd = { 'hugo' },
      args = { 'server', '-D' },
      name = 'Hugo Server',
      env = {},
      components = {
        'default',
        {
          'open_output',
          on_complete = 'never',
          on_start = 'always'
        },
        {
          'on_complete_dispose',
          statuses = { 'success' }
        }
      },
      metadata = {},
    }
  end,
  desc = 'Hugo Static Site Generator Server',
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    callback = function()
      return vim.fn.filereadable('hugo.toml') == 1
    end
  },
}
