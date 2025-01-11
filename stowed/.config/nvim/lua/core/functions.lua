function _G.wrap_cmd(cmd)
  return function() vim.cmd(cmd) end
end

