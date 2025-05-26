--[[
    plugin:
        ...
]]

local M = {
  "rcarriga/nvim-notify",
  tag = "v3.14.1",
  priority = 100,
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("notify")

  main_module.setup({})

  vim.notify = require("notify")
end

return M
