return {
  'kevinhwang91/nvim-hlslens',
  lazy = true,
  keys = {
    {
      'n',
      function()
        vim.cmd("silent! normal! " .. vim.v.count1 .. 'nzzzv')
        require('hlslens').start()
      end,
      noremap = true,
      silent = true,
      desc = "Search nav next instances."
    },
    {
      'N',
      function()
        vim.cmd("silent! normal! " .. vim.v.count1 .. "Nzzzv")
        require('hlslens').start()
      end,
      noremap = true,
      silent = true,
      desc = "Search nav prev instances."
    },
    {
      '*',
      function()
        vim.cmd([[silent! normal! *]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true,
      desc = "Search cword up."
    },
    {
      '#',
      function()
        vim.cmd([[silent! normal! #]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true,
      desc = "Search cword down."
    },
    {
      'g*',
      function()
        vim.cmd([[silent! normal! g*]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true,
      desc = "Search cword up (no word bounds)."
    },
    {
      'g#',
      function()
        vim.cmd([[silent! normal! g#]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true,
      desc = "Search cword down (no word bounds)."
    },
    {
      '<Leader>sqf',
      function()
        vim.schedule(function()
          if require('hlslens').exportLastSearchToQuickfix() then
            vim.cmd('cw')
          end
        end)
        return ':noh<CR>'
      end,
      mode = { 'n', 'x' },
      desc = "Export Last Search to QuickFix",
      expr = true
    }
  },
  config = true
}
