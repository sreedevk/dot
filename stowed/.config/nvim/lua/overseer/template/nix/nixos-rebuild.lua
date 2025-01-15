local overseer = require 'overseer'

return {
  name = "NixOS Switch",
  builder = function()
    return {
      cmd = { 'nixos-rebuild' },
      args = { "switch", "--flake", "./nixos", "--use-remote-sudo", "--impure", "-j", "8" },
      name = "nixos-rebuild switch",
      cwd = vim.fn.expand("~") .. "/.dot",
      env = {},
      components = {
        "default",
        {
          "open_output",
          on_complete = "never",
          on_start = "always"
        },
        {
          "on_complete_dispose",
          statuses = { "success" }
        }
      },
      metadata = {},
    }
  end,
  desc = "Home Manager Configuration Apply",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    dir = vim.fn.expand("~") .. "/.dot",
    callback = function(_)
      return vim.fn.system('uname -a'):match("NixOS") ~= nil
    end,
  },
}
