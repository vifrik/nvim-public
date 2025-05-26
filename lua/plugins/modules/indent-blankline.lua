--[[
    indent-blankline.nvim:
        display indent lines
]]

local M = {
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("ibl")

  main_module.setup()
end

return M
