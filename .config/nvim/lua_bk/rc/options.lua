-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.scriptencoding = 'utf-8'

local opt = vim.opt

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- 行番号表示
opt.number = true
-- 相対的な行番号表示
opt.relativenumber = true

opt.mouse = 'a'

opt.showmode = false

-- Sync clipboard between OS and Neovim
opt.clipboard = { 'unnamed', 'unnamedplus' }

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true
-- No create swapfile
opt.swapfile = false

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

--行数表示の横に余白を追加
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

-- 空白文字等、不可視な文字の可視化
opt.list = true
opt.listchars = {
  tab = '»-',
  extends = '»',
  precedes = '«',
  nbsp = '%',
  space = '⋅',
  eol = '↵',
}

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

opt.whichwrap = 'b,s,h,l'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true

opt.helplang = 'ja'
