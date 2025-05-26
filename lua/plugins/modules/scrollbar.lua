--[[
    plugin:
        ...
]]

local M = {
  "petertriho/nvim-scrollbar",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("scrollbar")

  main_module.setup({
    hide_if_all_visible = true,
    handlers = {
      gitsigns = true,
    },
    excluded_filetypes = {
      "dropbar_menu",
      "dropbar_menu_fzf",
      "DressingInput",
      "cmp_docs",
      "cmp_menu",
      "noice",
      "prompt",
      "TelescopePrompt",
      "NvimTree",
    },
    marks = {
      Cursor = {
        text = "█",
      },
    },
  })

  local utils = require("utils")
  local flare = utils.get_hlgroup("Flare")

  local highlights = {
    ScrollbarHandle = { fg = flare.bg, bg = flare.fg },
    ScrollbarCursor = { fg = flare.bg, bg = flare.fg },
    ScrollbarCursorHandle = { fg = flare.bg, bg = flare.fg },
  }

  utils.apply_highlights(highlights)
end

return M
