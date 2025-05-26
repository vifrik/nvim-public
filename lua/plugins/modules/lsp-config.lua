--[[
    nvim-lspconfig:
        configuration for built-in Nvim LSP client
]]

local function m(bufnr, mode, key, action, description)
  local opts = {}
  opts.buffer = bufnr
  return require("utils").map(mode, key, action, "[LspConfig] " .. description, opts)
end

local function on_attach(client, bufnr)
  -- Check if the LSP client supports specific capabilities
  if client.server_capabilities.signatureHelpProvider then
    m(bufnr, "n", "<C-p>", vim.lsp.buf.signature_help, "Signature help")
  end
  if client.server_capabilities.declarationProvider then
    m(bufnr, "n", "gD", vim.lsp.buf.declaration, "Goto declaration")
  end
  if client.server_capabilities.definitionProvider then
    m(bufnr, "n", "gd", vim.lsp.buf.definition, "Goto definition")
  end
  if client.server_capabilities.implementationprovider then
    m(bufnr, "n", "gi", vim.lsp.buf.implementation, "Goto implementation")
  end
  if client.server_capabilities.typeDefinitionProvider then
    m(bufnr, "n", "gtd", vim.lsp.buf.type_definition, "Goto type definition")
  end
  if client.server_capabilities.hoverProvider then
    m(bufnr, "n", "K", vim.lsp.buf.hover, "Hover")
  end
  if client.server_capabilities.renameProvider then
    m(bufnr, "n", "rn", vim.lsp.buf.rename, "Rename")
  end
  if client.server_capabilities.referencesProvider then
    m(bufnr, "n", "gr", vim.lsp.buf.references, "References")
  end
  if client.server_capabilities.codeActionProvider then
    m(bufnr, "n", "ca", vim.lsp.buf.code_action, "Show code actions")
  end

  -- Diagnostic key mappings
  m(bufnr, "n", "<Leader>e", vim.diagnostic.open_float, "Open diagnostics float")
  m(bufnr, "n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  m(bufnr, "n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  m(bufnr, "n", "<Leader>q", vim.diagnostic.setloclist, "Set location list")
end

local function clangd_on_attach(client, bufnr)
  m(bufnr, "n", "<C-h>", ":ClangdSwitchSourceHeader<Return>", "Switch between source and header file")
  on_attach(client, bufnr)
end

local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "creativenull/efmls-configs-nvim",
  },
  event = "BufReadPre",
}

function M.config()
  local main_module = require("lspconfig")

  local configs = {
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globlas = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    },
    pyright = {
      settings = {
        pyright = {
          disableOrganizeImports = true, -- Using Ruff
          analysis = {
            ignore = { "*" }, -- Using Ruff
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            autoImportCompletions = true,
          },
        },
      },
    },
    clangd = {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--offset-encoding=utf-16",
      },
      root_dir = main_module.util.root_pattern(".projroot", ".editorconfig", "compile_commands.json"),
      on_attach = clangd_on_attach,
    },
    jdtls = {
      cmd = {
        "/home/viktor/.local/share/nvim/mason/packages/jdtls/bin/jdtls",
      },
      -- TODO
      --[[settings = {
        java = {
          configuration = {
            name = "",
            path = "",
          },
        },
      },]]
      root_dir = main_module.util.root_pattern(".projroot", ".editorconfig"),
    },
    jsonls = {
      filetypes = { "json", "jsonc" },
    },
    bashls = {
      filetypes = { "sh" },
    },
  }
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  for server, config in pairs(configs) do
    if config.capabilities == nil then
      config.capabilities = capabilities
    end
    if config.on_attach == nil then
      config.on_attach = on_attach
    end
    if config.root_dir == nil then
      config.root_dir = main_module.util.root_pattern(".projroot", ".editorconfig")
    end
    main_module[server].setup(config)
  end

  -- lua
  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")
  -- python
  local ruff_l = require("efmls-configs.linters.ruff")
  local ruff_f = require("efmls-configs.formatters.ruff")
  -- c/cpp
  local cppcheck = require("efmls-configs.linters.cppcheck")
  local clang_format = require("efmls-configs.formatters.clang_format")
  -- json
  local jsonlint = require("efmls-configs.linters.jsonlint")
  local fixjson = require("efmls-configs.formatters.fixjson")
  -- sh
  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")
  main_module.efm.setup({
    root_dir = main_module.util.root_pattern(".projroot", ".editorconfig"),
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
    settings = {
      languages = {
        lua = { luacheck, stylua },
        python = { ruff_l, ruff_f },
        c = { clang_format },
        cpp = { cppcheck, clang_format },
        json = { jsonlint, fixjson },
        jsonc = { jsonlint, fixjson },
        sh = { shellcheck, shfmt },
      },
    },
  })
end

return M
