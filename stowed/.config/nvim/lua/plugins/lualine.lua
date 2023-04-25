return {
  'hoob3rt/lualine.nvim',
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = function()
    local lualine = require('lualine')

    local function macro_rec_stats()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "Recording @ " .. recording_register
      end
    end

    lualine.setup {
      options = {
        theme = "catppuccin",
        component_separators = { left = '', right = '' },
        section_separators = { left = ' ', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'buffers' },
        lualine_x = {
          { 'macro-rec', fmt = macro_rec_stats },
          '%S',
          'fileformat',
          'tabs'
        },
        lualine_y = { 'filetype', 'progress' },
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
          }
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
