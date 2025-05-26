local autocmd_manager = require("autocmd_manager")

autocmd_manager.register("YankHighlight", "TextYankPost", true, {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

autocmd_manager.register("PasteModeGroup", "InsertLeave", true, {
  desc = "Turn off paste mode when leaving insert",
  pattern = "*",
  command = "set nopaste",
})

autocmd_manager.register("LspFormattingGroup", "BufWritePre", true, {
  desc = "Auto-format on save",
  callback = require("utils").format_code,
})
