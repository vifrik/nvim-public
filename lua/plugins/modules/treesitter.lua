--[[
    nvim-treesitter:
        interface to treesitter to provide syntax highlighting, indentation, etc.
]]

local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  dependencies = {},
  commit = "cfc6f2c117aaaa82f19bcce44deec2c194d900ab",
}

function M.config()
  local main_module = require("nvim-treesitter.configs")

  main_module.setup({
    highlight = {
      enable = true,
      disable = {},
    },
    indent = {
      enable = true,
      disable = {},
    },
    ensure_installed = {
      "json",
      "yaml",
      "lua",
      "python",
      "c",
      "cpp",
    },
    autotag = {
      enable = true,
    },
  })

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
end

return M
