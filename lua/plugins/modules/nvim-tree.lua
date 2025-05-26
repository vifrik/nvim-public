--[[
    nvim-tree:
        file browser
]]

local M = {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  local main_module = require("nvim-tree")
  local api = require("nvim-tree.api")

  local function m(mode, key, action, description, opts)
    opts = opts or {}
    opts.noremap = false
    return require("utils").map(mode, key, action, "[Nvim-tree] " .. description, opts)
  end

  local function on_attach(bufnr)
    m("n", "q", api.tree.close, "Close tree", { buffer = bufnr })
    m("n", "a", api.fs.create, "Create file or folder", { buffer = bufnr })
    m("n", "d", api.fs.trash, "Trash file or folder", { buffer = bufnr })
    m("n", "D", api.fs.remove, "Delete file or folder", { buffer = bufnr })
    m("n", "r", api.fs.rename, "Rename file or folder", { buffer = bufnr })
    m("n", "x", api.fs.cut, "Cut file or folder to clipboard", { buffer = bufnr })
    m("n", "p", api.fs.paste, "Paste file or folder to clipboard", { buffer = bufnr })
    m("n", "y", api.fs.copy.node, "Copy file or folder to clipboard", { buffer = bufnr })
    m("n", "<Return>", api.node.open.edit, "Open file or expand folder", { buffer = bufnr })
    m("n", "<2-LeftMouse>", api.node.open.edit, "Open file or expand folder", { buffer = bufnr })
  end

  main_module.setup({
    on_attach = on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    view = {
      width = 60,
      float = {
        enable = false,
        open_win_config = {
          border = "none",
        },
      },
    },
    renderer = {
      highlight_git = true, -- Highlight git status
      group_empty = true,
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        git_placement = "after",
        modified_placement = "after",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true, -- Show git icons
          modified = true,
        },
        glyphs = {
          modified = "[+]",
          git = {
            unstaged = "M",
            staged = "A",
            unmerged = "U",
            renamed = "R",
            untracked = "?",
            deleted = "D",
            ignored = "!",
          },
        },
      },
    },
    git = {
      enable = true, -- Enable git integration
      ignore = false, -- Show ignored files
      show_on_dirs = true, -- Show git status on directories
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
  })

  m("n", "-", function()
    api.tree.open({ find_file = true })
  end, "Open file tree and locate file")

  m("n", "_", function()
    api.tree.open({ find_file = false })
  end, "Open file tree and locate file")
end

return M
