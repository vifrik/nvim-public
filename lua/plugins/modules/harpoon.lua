--[[
    harpoon.nvim:
        pin files for easy access
]]

local M = {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local main_module = require("harpoon")

  main_module.setup({})

  -- basic telescope configuration
  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
  end

  local function m(mode, key, action, description, opts)
    return require("utils").map(mode, key, action, "[Harpoon] " .. description, opts)
  end

  m("n", "<Leader>ha", function()
    main_module:list():add()
  end, "Add entry")
  m("n", "<Leader>hr", function()
    main_module:list():remove()
  end, "Remove entry")
  m("n", "<Leader>hh", function()
    toggle_telescope(main_module:list())
  end, "Open list")

  -- Toggle previous & next buffers stored within Harpoon list
  m("n", "<Leader>hn", function()
    main_module:list():prev()
  end, "Next entry")
  m("n", "<Leader>hp", function()
    main_module:list():next()
  end, "Prev entry")
end

return M
