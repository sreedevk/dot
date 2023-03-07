return {
  'echasnovski/mini.jump2d',
  keys = {
    { "S" }
  },
  config = function()
    require('mini.jump2d').setup({
      spotter = nil,
      labels = 'abcdefghijklmnopqrstuvwxyz',
      allowed_lines = {
        blank = true,
        cursor_before = true,
        cursor_at = true,
        cursor_after = true,
        fold = true,
      },
      allowed_windows = {
        current = true,
        not_current = false,
      },
      hooks = {
        before_start = nil,
        after_jump = nil,
      },
      mappings = {
        start_jumping = 'S',
      },
    })
  end
}
