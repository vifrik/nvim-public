-- Set map leader before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Configuration files
require("options")
require("highlights")
require("plugins")
require("mappings")
require("autocmds")
