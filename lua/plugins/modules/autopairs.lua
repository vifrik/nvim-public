--[[
    nvim-autopairs:
        automaticaly insert matching characters
]]

local M = {
  "windwp/nvim-autopairs",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("nvim-autopairs")

  main_module.setup({
    disable_filetype = {
      "TelescopePrompt",
      "vim",
    },
    enable_check_bracket_line = false,
  })
end

return M
