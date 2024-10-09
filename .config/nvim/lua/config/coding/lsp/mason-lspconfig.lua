local mason_lspconfig = safe_require('mason-lspconfig')

if not mason_lspconfig then
  return
end

local lsp_servers = {
  "bashls",
  "cssls",
  "dockerls",
  "eslint",
  "jsonls",
  "lua_ls",
  "grammarly",
  "sqlls",
  "terraformls",
  "yamlls",
}

-- Config
local config = {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = lsp_servers

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  ---@type boolean
  automatic_installation = true,
}

mason_lspconfig.setup(config)

