return {
  'phaazon/hop.nvim',
  branch = 'v2',
  lazy = true,
  cmd =  { "HopChar1", "HopLine", "HopWord", "HopWordCurrentLine" },
  config = function()
    require('hop').setup({
      keys = 'etovxqpdygfblzhckisuran'
    })
  end
}
