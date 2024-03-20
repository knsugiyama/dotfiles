require('default_settings')
require('keymaps')

local osName = os.getenv("OS") or io.popen("uname -s"):read("*l")

if osName == "Windows_NT" then
  require('windows-shell')
end

-- load plugin manager
require('lazy_nvim')
