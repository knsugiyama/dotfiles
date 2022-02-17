local create_setup = require("rc.lsp.utils").create_setup

local root_pattern = require("lspconfig").util.root_pattern

local function no_formatting(client)
  client.resolved_capabilities.document_formatting = false
end

return {
  tsserver = require "rc.lsp.configs.tsserver",
  cssls = create_setup { on_attach = no_formatting },
  html = create_setup { on_attach = no_formatting },
  jsonls = create_setup {
    on_attach = no_formatting,
    filetypes = { "json", "jsonc" },
    settings = { json = { schemas = require("schemastore").json.schemas() } },
  },
  sumneko_lua = require "rc.lsp.configs.sumneko_lua",
}
