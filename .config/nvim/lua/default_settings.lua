vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true

vim.o.mouce = 'a'
vim.o.clipboard = 'unnamedplus'

-- 全角記号が半角文字と重なってしまう問題の対処
vim.o.ambiwidth = 'double'

-- 相対的な行番号表示
vim.o.relativenumber = true
vim.o.termguicolors = true
--
-- カーソル行のハイライト
vim.o.cursorline = true

-- 絵文字
vim.o.emoji = true

-- 空白文字等、不可視な文字の可視化
vim.o.list = true
vim.opt.listchars = { tab = '»-', extends = '»', precedes = '«', nbsp = '%', eol = '↵' }

-- カーソル行からの相対的な行番号を表示する
vim.o.relativenumber = true

-- tab -> space
vim.o.smarttab = true

-- tabキー押下時に2space挿入する
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
