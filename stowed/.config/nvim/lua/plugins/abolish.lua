return {
  {
    'tpope/vim-abolish',
    lazy = true,
    keys = {
      { 'crc', desc = "camelCase cWord" },
      { 'crs', desc = "snake_case cWord" },
      { 'crm', desc = "MixedCase cWord" },
      { 'cru', desc = "UPPER_CASE cWord" },
      { 'cr-', desc = "dash-case cWord" },
      { 'cr.', desc = "dot.case cWord" },
      {
        '<leader><leader>s',
        ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>",
        desc = "Find & Replace (Buffer)",
        noremap = true
      },
      {
        '<leader><leader>s',
        [["zy:'<'>S/<C-r><C-o>"//c<left><left>]],
        mode = 'x',
        silent = false,
        desc = 'Find & Replace (Visual)',
      },
    },
    config = function()
      local abbrev = function(lhs, rhs)
        vim.cmd("Abolish " .. lhs .. " " .. rhs)
      end

      abbrev("teh", "the")
      abbrev("exampel", "example")
    end
  }
}
