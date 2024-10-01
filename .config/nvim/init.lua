require('basic_settings')
require('basic_keymaps')
require('basic_autocommands')

local osName = os.getenv("OS") or io.popen("uname -s"):read("*l")

if osName == "Windows_NT" then
  require('windows-shell')
end

-- load plugin manager
