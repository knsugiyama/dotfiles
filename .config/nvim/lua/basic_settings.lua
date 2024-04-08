-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 行番号表示
vim.opt.number = true
-- 相対的な行番号表示
vim.o.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
-- No create swapfile
vim.opt.swapfile = false

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

 --行数表示の横に余白を追加
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

-- 空白文字等、不可視な文字の可視化
vim.opt.list = true
vim.opt.listchars = {
  tab = '»-',
  extends = '»',
  precedes = '«',
  nbsp = '%',
  space = '⋅',
  eol = '↵'
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.whichwrap = 'b,s,h,l'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.opt.helplang = 'ja'

