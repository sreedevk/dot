return {
  'stevearc/overseer.nvim',
  lazy = true,
  cmd = { 'OverseerToggle', 'OverseerRun' },
  opts = {},
  config = function ()
    require('overseer').setup()
  end
}
