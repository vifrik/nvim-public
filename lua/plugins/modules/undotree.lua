--[[
    mason.nvim:
        portable package manager. easily install and manage LSP servers, DAP servers, linters, and formatters.
]]

local M = {
  "jiaoshijie/undotree",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("undotree")

  main_module.setup({
    float_diff = false, -- using float window previews diff, set this `true` will disable layout option
    layout = "left_left_bottom", -- "left_bottom", "left_left_bottom"
    position = "left", -- "right", "bottom"
    ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
    window = {
      winblend = 30,
    },
    keymaps = {
      ["j"] = "move_next",
      ["k"] = "move_prev",
      ["gj"] = "move2parent",
      ["J"] = "move_change_next",
      ["K"] = "move_change_prev",
      ["<cr>"] = "action_enter",
      ["p"] = "enter_diffbuf",
      ["q"] = "quit",
    },
  })

  local function m(mode, key, action, description, opts)
    return require("utils").map(mode, key, action, "[Undotree] " .. description, opts)
  end

  m("n", "U", function()
    main_module.toggle()
  end, "Toggle tree")
end

return M
