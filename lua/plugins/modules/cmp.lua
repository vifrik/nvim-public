--[[
    nvim-cmp:
        completion engine
    LuaSnip:
        snippet engine
]]

local M = {
  "hrsh7th/nvim-cmp",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    -- snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- pictograms
    "onsails/lspkind-nvim",
  },
}

function M.config()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  -- Load snippets
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_snipmate").load({ path = { "./snippets" } })

  luasnip.setup({
    region_check_events = "InsertEnter",
    delete_check_events = "InsertLeave",
  })

  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = "menu,menuone,noinsert,select",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-u>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
    }),
    formatting = {
      expandable_indicator = true,
      format = function(entry, vim_item)
        vim_item.menu = entry.source.name
        return lspkind.cmp_format({
          --maxwidth = 50,
          ellipsos_char = "...",
          show_labelDetails = true,
        })(entry, vim_item)
      end,
    },
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        scrolloff = 3,
        scrollbar = true,
      },
      documentation = {
        winhighlight = "FloatBorder:NormalFloat",
      },
    },
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
