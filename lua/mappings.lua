local function m(mode, key, action, description, opts)
  return require("utils").map(mode, key, action, "[User] " .. description, opts)
end

m("i", "jj", function()
  vim.api.nvim_command("stopinsert")
end, "Leave insert mode")

m("n", "<Leader>s", ":split<Return><C-w>w", "Split horizontal")
m("n", "<Leader>v", ":vsplit<Return><C-w>w", "Split vertical")

m("n", "<Leader><Leader>", "<C-w>w", "Switch panel")
m("n", "<Leader><Left>", "<C-w>h", "Switch panel left")
m("n", "<Leader><Up>", "<C-w>k", "Switch panel up")
m("n", "<Leader><Down>", "<C-w>j", "Switch panel down")
m("n", "<Leader><Right>", "<C-w>l", "Switch panel right")

m("n", "<C-w><Left>", "<C-w><", "Resize left")
m("n", "<C-w><Right>", "<C-w>>", "Resize right")
m("n", "<C-w><Up>", "<C-w>+", "Resize up")
m("n", "<C-w><Down>", "<C-w>-", "Resize down")

m("n", "<Esc>", ":noh<Return>", "Clear search")

m("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
m("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")

m("v", "p", 'P', "Put without yanking")
m({ "n", "v" }, "<Leader>y", '"+y', "Copy without yanking")
m({ "n", "v" }, "<Leader>d", '"_d', "Delete without yanking")
m({ "n", "v" }, "<Leader>D", '"_D', "Delete to end of line without yanking")
m({ "n", "v" }, "<Leader>c", '"_c', "Change without yanking")
m({ "n", "v" }, "<Leader>C", '"_C', "Change to end of line without yanking")

m("v", ">", ">gv", "Increase indent")
m("v", "<", "<gv", "Reduce indent")

m("n", "<C-d>", "<C-d>zz", "Page down and center")
m("n", "<C-u>", "<C-u>zz", "Page up and center")

m("n", "<Leader>dd", function()
  vim.api.nvim_buf_delete(0, {})
end, "Delete buffer")
