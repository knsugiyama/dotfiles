require "plugins"
require "default-settings"
require "settings"
require "colors"
require "keymaps"

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
