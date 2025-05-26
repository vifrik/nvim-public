local M = {}
local autocmds = {}

function M.enable(autocmd_name, verbose)
  local autocmd = autocmds[autocmd_name]

  if autocmd.id then
    if verbose then
      print("Autocommand group '" .. autocmd_name .. "' is already enabled.")
    end
    return
  end

  autocmd.id = vim.api.nvim_create_autocmd(autocmd.event, autocmd.options)
  if verbose then
    print("Autocommand '" .. autocmd_name .. "' enabled.")
  end
end

function M.disable(autocmd_name, verbose)
  local autocmd = autocmds[autocmd_name]

  if autocmd.id == nil then
    if verbose then
      print("Autocommand '" .. autocmd_name .. "' is already disabled.")
    end
    return
  end

  vim.api.nvim_del_autocmd(autocmd.id)
  autocmd.id = nil
  if verbose then
    print("Autocommand '" .. autocmd_name .. "' disabled.")
  end
end

function M.toggle(autocmd_name, verbose)
  local autocmd = autocmds[autocmd_name]
  if autocmd.id == nil then
    M.enable(autocmd_name, verbose)
  else
    M.disable(autocmd_name, verbose)
  end
end

function M.register(autocmd_name, event, enabled, options)
  if autocmds[autocmd_name] then
    print("Autocommand '" .. autocmd_name .. "' is already registered.")
    return
  end

  autocmds[autocmd_name] = {
    id = nil,
    event = event,
    options = options,
  }

  if enabled then
    M.enable(autocmd_name)
  end

  vim.api.nvim_create_user_command("Enable" .. autocmd_name, function()
    M.enable(autocmd_name, true)
  end, {})

  vim.api.nvim_create_user_command("Disable" .. autocmd_name, function()
    M.disable(autocmd_name, true)
  end, {})

  vim.api.nvim_create_user_command("Toggle" .. autocmd_name, function()
    M.toggle(autocmd_name, true)
  end, {})
end

return M
