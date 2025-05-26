--[[
    which-key.nvim:
        keymap helper
]]

local M = {
  "folke/which-key.nvim",
  lazy = false,
  dependencies = {},
  event = "VimEnter",
}

function M.config()
  local main_module = require("which-key")

  main_module.setup({})

  local function m(mode, key, action, description, opts)
    return require("utils").map(mode, key, action, "[WhichKey] " .. description, opts)
  end

  m("n", "<Leader>wk", main_module.show, "All keymaps")
end

return M
