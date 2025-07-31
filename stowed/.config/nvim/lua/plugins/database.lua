return {
  {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    dependencies = {
      {
        'tpope/vim-dadbod',
        lazy = true,
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true,
      },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    ft = { 'sql', 'mysql', 'plsql' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }
}
