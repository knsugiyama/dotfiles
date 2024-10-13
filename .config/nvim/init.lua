if vim.loader then
  vim.loader.enable()
end

require('rc.options')
require('rc.keymaps')
require('rc.utils')
require('rc.autocmds')

local osName = os.getenv("OS") or io.popen("uname -s"):read("*l")

if osName == "Windows_NT" then
  require('rc.windows-shell')
end

-- load plugin manager
require("rc.lazy")

vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])

