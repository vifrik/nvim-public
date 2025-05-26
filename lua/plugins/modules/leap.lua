--[[
    leap.nvim:
        reach any destination in a very fast, uniform way
]]

local M = {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("leap")

  main_module.setup({})

  --main_module.create_default_mappings()

  local function m(mode, key, action, description, opts)
    opts = opts or {}
    opts.noremap = false
    return require("utils").map(mode, key, action, "[Leap] " .. description, opts)
  end

  m({ "n", "x", "o" }, "s", function()
    main_module.leap({})
  end, "Leap forward")

  m({ "n", "x", "o" }, "S", function()
    main_module.leap({ backward = true })
  end, "Leap backward")
end

return M
