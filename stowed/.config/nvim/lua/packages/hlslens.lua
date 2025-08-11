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
      silent = true
    },
    {
      'N',
      function()
        vim.cmd("silent! normal! " .. vim.v.count1 .. "Nzzzv")
        require('hlslens').start()
      end,
      noremap = true,
      silent = true
    },
    {
      '*',
      function()
        vim.cmd([[silent! normal! *]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      '#',
      function()
        vim.cmd([[silent! normal! #]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      'g*',
      function()
        vim.cmd([[silent! normal! g*]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      'g#',
      function()
        vim.cmd([[silent! normal! g#]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      '<Leader>L',
      function()
        vim.schedule(function()
          if require('hlslens').exportLastSearchToQuickfix() then
            vim.cmd('cw')
          end
        end)
        return ':noh<CR>'
      end,
      mode = { 'n', 'x' },
      expr = true
    }
  },
  config = true
}
