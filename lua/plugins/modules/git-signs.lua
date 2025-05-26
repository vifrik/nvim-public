--[[
    gitsigns.nvim:
        git decorations
]]

local M = {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("gitsigns")

  main_module.setup({
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
  })

  local function m(mode, key, action, description, opts)
    return require("utils").map(mode, key, action, "[Gitsigns] " .. description, opts)
  end

  m("n", "]h", main_module.next_hunk, "Next hunk")
  m("n", "[h", main_module.prev_hunk, "Previous hunk")
  m("n", "<Leader>gho", main_module.preview_hunk, "Preview hunk under cursor ")
  m("n", "<Leader>ghr", main_module.reset_hunk, "Reset hunk under cursor ")
end

return M
