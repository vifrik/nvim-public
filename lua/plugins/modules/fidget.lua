--[[
    fidget.nvim:
        display information toast in bottom corner
]]

local M = {
  "j-hui/fidget.nvim",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("fidget")

  main_module.setup({})
end

return M
