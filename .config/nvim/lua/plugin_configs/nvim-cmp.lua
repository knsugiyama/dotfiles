-- See `:help cmp`
local cmp = require ("cmp")
local types = require("cmp.types")
local luasnip = require ("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup ({
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        cmp_tabnine = "[TabNine]",
        copilot = "[Copilot]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[NeovimLua]",
        latex_symbols = "[LaTeX]",
        path = "[Path]",
        omni = "[Omni]",
        spell = "[Spell]",
        emoji = "[Emoji]",
        calc = "[Calc]",
        rg = "[Rg]",
        treesitter = "[TS]",
        dictionary = "[Dictionary]",
        mocword = "[mocword]",
        cmdline = "[Cmd]",
        cmdline_history = "[History]",
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = "copilot", priority = 90 }, --For luasnip users.
    { name = "nvim_lsp", priority = 100 },
    { name = "luasnip", priority = 20 }, --For luasnip users.
    { name = "path", priority = 100 },
    { name = "emoji", insert = true, priority = 60 },
    { name = "nvim_lua", priority = 50 },
    { name = "nvim_lsp_signature_help", priority = 80 },
  }, {
    { name = "buffer", priority = 50 },
    { name = "spell", priority = 40 },
    { name = "treesitter", priority = 30 },
  }),
})

cmp.setup.filetype({ "gitcommit", "markdown" }, {
  sources = cmp.config.sources({
    { name = "copilot", priority = 90 }, -- For luasnip users.
    { name = "nvim_lsp", priority = 100 },
    { name = "luasnip", priority = 80 }, -- For luasnip users.
    { name = "rg", priority = 70 },
    { name = "path", priority = 100 },
    { name = "emoji", insert = true, priority = 60 },
  }, {
    { name = "buffer", priority = 50 },
    { name = "spell", priority = 40 },
    { name = "treesitter", priority = 30 },
    { name = "mocword", priority = 60 },
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  }, {}),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "c" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "c" }),
    ["<C-y>"] = {
      c = cmp.mapping.confirm({ select = false }),
    },
    ["<C-q>"] = {
      c = cmp.mapping.abort(),
    },
  },
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" }, { { name = "cmdline_history" } } }),
})
