local overseer = require 'overseer'

return {
  name = "janet jpm build",
  builder = function()
    return {
      cmd = { 'jpm' },
      args = { "build" },
      name = "jpm build",
      components = {
        "on_exit_set_status",
        {
          "on_complete_notify",
          system = "unfocused"
        },
        {
          "on_output_quickfix",
          open = true,
          open_height = 8,
          open_on_exit = "failure"
        },
      },
      metadata = {},
    }
  end,
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    callback = function()
      return vim.fn.filereadable('project.janet') == 1
    end
  },
}
