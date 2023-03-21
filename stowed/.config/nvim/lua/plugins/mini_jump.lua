return {
  'echasnovski/mini.jump',
  config = function()
    require('mini.jump').setup({
      mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = 't',
        backward_till = 'T',
        repeat_jump = '',
      },
      delay = {
        highlight = 250,
        idle_stop = 10000000,
      },
    })
  end
}
