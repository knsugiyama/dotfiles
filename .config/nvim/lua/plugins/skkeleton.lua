return {
  'vim-skk/skkeleton',
  event = 'VeryLazy',
  config = function()
    vim.fn['skkeleton#config'] {
      globalDictionaries = { '~/.config/.skk/SKK-JISYO.L' },
      eggLikeNewline = true,
    }
    vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-enable)', { noremap = false })
    -- vim.keymap.set({ 'i', 'c' }, 'L', '<Plug>(skkeleton-disable)', { noremap = false })
  end,
}
