local o = vim.opt
local g = vim.g

-- Enable impatient.nvim like behaviour
vim.loader.enable()

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Make line numbers default
o.number = true
o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = "a"

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = "yes"

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Set indendation rules
o.expandtab = true
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4

-- Preview substitutions live, as you type!
o.inccommand = "split"

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- Set highlight on search
o.hlsearch = true

-- Enable setting the terminal's title
o.title = true

-- Define session options to specify what to save and restore
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = "v:lua.vim.treesitter.foldtext()"
