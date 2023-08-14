require('lint').linters_by_ft = {
  lua = { 'luacheck' },
  zsh = { 'shellcheck' },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  yaml = { 'yamllint' },
  markdown = { 'vale' }
}
require("lint").try_lint()
