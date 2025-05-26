--[[
    lualine.nvim:
        statusline at bottom of buffer
]]

local M = {
  "nvim-lualine/lualine.nvim",
  lazy = false,
}

function M.config()
  local main_module = require("lualine")

  local ft_extension = {
    sections = { lualine_a = { "filetype" } },
    filetypes = { "undotree", "NvimTree" },
  }

  main_module.setup({
    options = {
      icons_enabled = true,
      theme = vim.g.colors_name,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      disabled_filetypes = { "undotree", "NvimTree" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        {
          "filename",
          file_status = true,
          path = 2,
        },
      },
      lualine_c = { "branch" },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = "E", warn = "W", hint = "H", info = "I" },
        },
        "encoding",
        "filetype",
      },
      lualine_y = {},
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 1,
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    },
    extensions = { "aerial", "lazy", "mason", ft_extension },
  })
end

return M
