local overseer = require 'overseer'

return {
  name = "HLedger Check",
  builder = function()
    return {
      cmd = { 'hledger' },
      args = { 'check', '-s' },
      name = "hledger check",
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
  desc = "HLedger Check",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    callback = function()
      return vim.env.LEDGER_FILE ~= nil
    end,
  },
}
