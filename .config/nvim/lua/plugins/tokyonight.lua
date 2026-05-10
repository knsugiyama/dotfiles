local isPluginColor = function()
  return vim.startswith(vim.env.NVIM_COLORSCHEME, 'tokyonight')
end

return {
  'folke/tokyonight.nvim',
  priority = isPluginColor() and 1000 or 50,
  event = isPluginColor() and { 'UiEnter' } or { 'ColorScheme' },
  init = function()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function(args)
        if not vim.startswith(args.match, 'tokyonight') then
          return
        end
        vim.g.colors_name = args.match
      end,
    })
  end,
  opts = {},
  config = function(_, opts)
    local k = require 'tokyonight'
    k.setup(opts)
    if isPluginColor() then
      vim.cmd.colorscheme(vim.env.NVIM_COLORSCHEME)
    end
  end,
}
