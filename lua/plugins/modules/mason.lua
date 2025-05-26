--[[
    mason.nvim:
        portable package manager. easily install and manage LSP servers, DAP servers, linters, and formatters.
]]

local M = {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("mason")

  main_module.setup({})
end

return M
