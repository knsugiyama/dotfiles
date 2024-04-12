return {
  {
    'stevearc/conform.nvim',
    event = {
      'BufWritePre',
    },

    cmd = {
      'ConformInfo',
    },

    keys = {
      {
        '<leader>f',
        function()
          require('conform').format {
            async = true,
            lsp_fallback = true,
          }
        end,
        mode = '',
        desc = 'Format buffer',
      },
      {
        '<leader>F',
        function()
          require('conform').list_all_formatters()
        end,
      },
    },

    opts = {
      formatters_by_ft = {
        -- See https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
        css = { { 'prettierd', 'prettier' } },
        graphql = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        markdown = { { 'prettierd', 'prettier' } },
        python = { 'isort', 'black' },
        sql = { 'sql-formatter' },
        svelte = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        yaml = { 'prettier' },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
