local overseer = require 'overseer'

return {
  name = "Janet Run",
  builder = function()
    return {
      cmd = { 'janet' },
      args = { vim.fn.expand("%") },
      name = "janet run",
      components = {
        "on_exit_set_status",
        {
          "on_output_quickfix",
          open = true,
          open_height = 8,
          open_on_exit = "always"
        },
      },
      metadata = {},
    }
  end,
  desc = "Janet Run Script",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    filetype = { "janet" },
  },
}
