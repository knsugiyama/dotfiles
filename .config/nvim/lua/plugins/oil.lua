return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  event = 'VeryLazy',
  -- Optional dependencies
  dependencies = {
    { 'nvim-mini/mini.icons', opts = {} },
    { 'refractalize/oil-git-status.nvim' },
  },
  keys = {
    {
      '<leader>f',
      function()
        vim.cmd.Oil()
      end,
    },
  },
  opts = function()
    ---@type oil.setupOpts
    return {
      keymaps = {
        ['?'] = 'actions.show_help',
        ['-'] = 'actions.parent',
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local ignore_list = { '.DS_Store' }
          return vim.tbl_contains(ignore_list, name)
        end,
      },
      delete_to_trash = true,
      win_options = {
        signcolumn = 'yes:2',
      },
    }
  end,
  config = function(_, opts)
    require('oil').setup(opts)
    require('oil-git-status').setup()
  end,
}
