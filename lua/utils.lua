local M = {}

function M.map(mode, key, action, description, opts)
  opts = opts or {}
  opts.desc = description
  if opts.noremap == nil then
    opts.noremap = true
  end
  if opts.silent == nil then
    opts.silent = true
  end
  vim.keymap.set(mode, key, action, opts)
end

function M.is_plugin_installed(name)
  local ok, _ = pcall(require, name)
  if not ok then
    vim.notify(name .. " is not installed", vim.log.levels.WARN)
  end
  return ok
end

function M.get_hlgroup(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl.foreground and string.format("#%06x", hl.foreground) or nil
  local bg = hl.background and string.format("#%06x", hl.background) or nil
  return { fg = fg, bg = bg }
end

function M.create_custom_highlight(group_name, fg_color, bg_color, style)
  vim.api.nvim_set_hl(0, group_name, {
    fg = fg_color, -- Foreground color
    bg = bg_color, -- Background color
    style = style, -- Style can be 'bold', 'italic', 'underline', etc.
  })
end

function M.apply_highlights(highlights)
  for group, colors in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, colors)
  end
end

function M.format_code()
  local efm = vim.lsp.get_active_clients({ name = "efm" })

  if vim.tbl_isempty(efm) then
    return
  end

  vim.lsp.buf.format({ name = "efm", async = false, timeout_ms = 2000 })
end

function M.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

--require("utils").create_custom_highlight("NormalLight", "#cdd6f4", "#26263a")

return M
