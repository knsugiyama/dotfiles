local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.termguicolors = true

-- 全角記号が半角文字と重なってしまう問題の対処
opt.ambiwidth = 'double'

-- 相対的な行番号表示
opt.relativenumber = true
opt.termguicolors = true
--
-- カーソル行のハイライト
opt.cursorline = true

-- 絵文字
opt.emoji = true

-- 空白文字等、不可視な文字の可視化
opt.list = true
opt.listchars = { tab = '»-', extends = '»', precedes = '«', nbsp = '%', eol = '↵' }

-- カーソル行からの相対的な行番号を表示する
opt.relativenumber = true

-- tab -> space
opt.smarttab = true

-- tabキー押下時に2space挿入する
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
