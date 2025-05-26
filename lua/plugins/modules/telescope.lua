--[[
    telescope.nvim:
        extendable fuzzy finder over lists
]]

local M = {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local sorters = require("telescope.sorters")
  local previewers = require("telescope.previewers")

  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
          preview_cutoff = 120,
        },
        vertical = {
          prompt_position = "top",
          mirror = true,
        },
        width = 0.9,
        height = 0.9,
      },
      file_sorter = sorters.get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      path_display = function(opts, path)
        local tail = require("telescope.utils").path_tail(path)
        return string.format("%s (%s)", tail, path)
      end,
      winblend = 0,
      border = {},
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      mappings = {
        n = { ["q"] = actions.close },
      },
    },
    pickers = {
      buffers = {
        show_all_buffers = true,
        sort_mru = true,
        mappings = {
          i = {
            ["<C-d>"] = "delete_buffer",
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")

  local utils = require("utils")
  local function m(mode, key, action, description, opts)
    opts = opts or {}
    opts.noremap = false
    return utils.map(mode, key, action, "[Telescope] " .. description, opts)
  end

  m("n", "<Leader>fm", "<Cmd>Telescope marks<CR>", "Find marks")
  m("n", "<Leader>fc", "<Cmd>Telescope git_commits<CR>", "Git commits")
  m("n", "<Leader>fq", "<Cmd>Telescope git_status<CR>", "Git status")
  m("n", "<Leader>fk", "<Cmd>Telescope keymaps<CR>", "Find keymaps")
  m("n", "<Leader>fw", "<Cmd>Telescope live_grep<CR>", "Live grep")
  m("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", "Find buffers")
  m("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", "Help page")
  m("n", "<Leader>fo", "<Cmd>Telescope oldfiles<CR>", "Find oldfiles")
  m("n", "<Leader>fz", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Find in current buffer")
  m("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", "Find files")
  m("n", "<Leader>fr", "<Cmd>Telescope lsp_references<CR>", "Find references")
  m("n", "<Leader>fa", "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", "Find all files")
  m("n", "<Leader>fs", "<Cmd>Telescope lsp_document_symbols<CR>", "Find symbols in current buffer")
  m("n", "<Leader>fj", "<Cmd>Telescope jumplist<CR>", "Find jumplist entries")
  m("n", "<Leader>fn", "<Cmd>Telescope notify<CR>", "Find previous notifies")

  local normal = utils.get_hlgroup("Normal")
  local normal_float = utils.get_hlgroup("NormalFloat")
  local normal_sb = utils.get_hlgroup("NormalSB")
  local cursor_line = utils.get_hlgroup("CursorLine")
  local green = utils.get_hlgroup("String").fg

  local telescope_highlights = {
    TelescopeBorder = { fg = normal_sb.bg, bg = normal.bg },
    TelescopeNormal = { bg = normal.bg },

    TelescopePreviewBorder = { fg = normal_sb.bg, bg = cursor_line.bg }, -- right hand side
    TelescopePreviewNormal = { bg = cursor_line.bg },
    TelescopePreviewTitle = { fg = normal_sb.bg, bg = green },

    TelescopePromptBorder = { fg = normal_sb.bg, bg = normal_float.bg }, -- top left header
    TelescopePromptNormal = { fg = normal.fg, bg = normal_float.bg }, -- search bar
    TelescopePromptPrefix = { fg = normal.fg, bg = normal_float.bg }, -- magnifying glass
    TelescopePromptTitle = { fg = normal_sb.bg, bg = green }, -- find files title

    TelescopeResultsBorder = { fg = normal_sb.bg, bg = normal_sb.bg },
    TelescopeResultsNormal = { bg = normal_sb.bg },
    TelescopeResultsTitle = { fg = normal_sb.bg, bg = normal_sb.bg },
  }

  utils.apply_highlights(telescope_highlights)
end

return M
