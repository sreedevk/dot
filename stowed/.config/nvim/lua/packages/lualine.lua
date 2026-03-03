return {
  'hoob3rt/lualine.nvim',
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = function()
    local lualine = require('lualine')
    local overseer = require('overseer')

    local function macro_rec_stats()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "@" .. recording_register
      end
    end

    lualine.setup {
      options = {
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = ' ', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { function() return vim.fn.pathshorten(vim.fn.getcwd()) end },
        },
        lualine_x = {
          { 'macro-rec', fmt = macro_rec_stats, color = { fg = "yellow", gui = "bold" } },
        },
        lualine_y = {
          {
            "overseer",
            label = "",     -- Prefix for task counts
            colored = true, -- Color the task icons and counts
            symbols = {
              [overseer.STATUS.FAILURE] = "F:",
              [overseer.STATUS.CANCELED] = "C:",
              [overseer.STATUS.SUCCESS] = "S:",
              [overseer.STATUS.RUNNING] = "R:",
            },
            unique = false, -- Unique-ify non-running task count by name
            status = nil,   -- List of task statuses to display
            filter = nil,   -- Function to filter out tasks you don't wish to display
          },
          'filetype',
          'filesize',
        },
        lualine_z = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = 'DiagnosticError',
              warn  = 'DiagnosticWarn',
              info  = 'DiagnosticInfo',
              hint  = 'DiagnosticHint',
            },
            symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
          'location',
          'selectioncount'
        },
      },
    }


    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh({
          place = { "statusline" },
        })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(50, 0, vim.schedule_wrap(
          function()
            lualine.refresh({ place = { "statusline" } })
          end)
        )
      end,
    })
  end
}
