--[[
    auto-session:
        session management that provides seamless automatic session management
]]

local M = {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = {},
}

function M.config()
  local main_module = require("auto-session")

  main_module.setup({
    enabled = true, -- Enables/disables auto creating, saving and restoring
    root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Root dir where sessions will be stored
    auto_save = true, -- Enables/disables auto saving session on exit
    auto_restore = true, -- Enables/disables auto restoring session on start
    auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
    suppressed_dirs = nil, -- Suppress session restore/create in certain directories
    allowed_dirs = nil, -- Allow session restore/create in certain directories
    auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
    use_git_branch = true, -- Include git branch name in session name
    lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
    bypass_save_filetypes = nil, -- List of file types to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
    close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
    args_allow_single_directory = true, -- Follow normal sesion save/load logic if launched with a single directory as the only argument
    args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
    continue_restore_on_error = true, -- Keep loading the session even if there's an error
    cwd_change_handling = false, -- Follow cwd changes, saving a session before change and restoring after
    log_level = "error", -- Sets the log level of the plugin (debug, info, warn, error).

    session_lens = {
      load_on_setup = false, -- Initialize on startup (requires Telescope)
    },
  })
end

return M
