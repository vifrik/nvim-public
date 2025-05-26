--[[
    git.nvim:
        git commands in nvim
]]

local M = {
  "dinhhuy258/git.nvim",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("git")

  main_module.setup({
    keymaps = {
      blame = "<leader>gb",
      quit_blame = "q",
    },
  })

  local function m(mode, key, action, description, opts)
    opts = opts or {}
    opts.noremap = false
    return require("utils").map(mode, key, action, "[Git] " .. description, opts)
  end

  m("n", "<Leader>gr", function()
    require("git.revert").open(true)
  end, "Revert file specific")
  m("n", "<Leader>gR", function()
    require("git.revert").open(false)
  end, "Revert global")
  m("n", "<Leader>gb", function()
    require("git.blame").blame()
  end, "Blame")
  m("n", "<Leader>gd", function()
    require("git.diff").open()
  end, "Diff open")
  m("n", "<Leader>gD", function()
    require("git.diff").close()
  end, "Diff close")

  -- Remove unused binds
  vim.keymap.del("n", "<Leader>gn") -- git.browse.create_pull_request
  vim.keymap.del("n", "<Leader>go") -- git.browse.open
  vim.keymap.del("n", "<Leader>gp") -- git.browse.pull_request
end

return M
