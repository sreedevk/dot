local mini_jump_ok, mini_jump = pcall(require, 'mini.jump')
if not mini_jump_ok then
  return
end

mini_jump.setup({
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

local mini_jump_2d_ok, mini_jump_2d = pcall(require, 'mini.jump2d')
if not mini_jump_2d_ok then
  return
end

mini_jump_2d.setup({
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
