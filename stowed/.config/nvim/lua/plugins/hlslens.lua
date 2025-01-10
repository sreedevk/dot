return {
  'kevinhwang91/nvim-hlslens',
  lazy = false,
  keys = {
    {
      "n",
      function()
        vim.cmd("normal! " .. vim.v.count1 .. 'n')
        require('hlslens').start()
      end,
      noremap = true,
      silent = true
    },
    {
      "N",
      function()
        vim.cmd("normal! " .. vim.v.count1 .. "N")
        require('hlslens').start()
      end,
      noremap = true,
      silent = true
    },
    {
      '*',
      function()
        vim.cmd([[normal! *]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      '#',
      function()
        vim.cmd([[normal! #]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      'g*',
      function()
        vim.cmd([[normal! g*]])
        require('hlslens').start()
      end,
      mode = 'n',
      noremap = true,
      silent = true
    },
    {
      'g#',
      function()
        vim.cmd([[normal! g#]])
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
