return {
  'JellyApple102/easyread.nvim',
  cmd = { 'EasyreadToggle', 'EasyreadSaccadeInterval', 'EasyreadSaccadeReset', 'EasyreadUpdateWhileInsert' },
  config = function()
    require('easyread').setup {
      hlValues = {
        ['1'] = 1,
        ['2'] = 1,
        ['3'] = 2,
        ['4'] = 2,
        ['fallback'] = 0.4
      },
      hlgroupOptions = { link = 'Bold' },
      fileTypes = { 'text' },
      saccadeInterval = 0,
      saccadeReset = false,
      updateWhileInsert = true
    }
  end
}
