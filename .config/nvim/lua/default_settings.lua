vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- search {{{
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- }}}

-- edit {{{
-- Enable break indent
vim.o.breakindent = true
-- tabキー押下時に2space挿入する
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
-- tab -> space
vim.o.smarttab = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- }}}

-- Display {{{
-- 相対的な行番号表示
vim.o.relativenumber = true
-- 空白文字等、不可視な文字の可視化
vim.o.list = true
vim.opt.listchars = {
  tab = '»-',
  extends = '»',
  precedes = '«',
  nbsp = '%',
  space = '⋅',
  eol = '↵'
}
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.colorcolumn = { 150 }
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes' --行数表示の横に余白を追加
-- }}}

-- Cursor {{{
vim.opt.whichwrap = 'b,s,h,l'
vim.opt.scrolloff = 15
-- }}}

-- Mouse {{{
vim.opt.mouse = 'a'
-- }}}

-- File {{{
-- Save undo history
vim.o.undofile = true
-- No create swapfile
vim.opt.swapfile = false
-- }}}

-- Others {{{
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.opt.helplang = 'ja'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- }}}

