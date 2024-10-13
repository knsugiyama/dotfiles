local utils = require("rc.utils")

local wk = utils.safe_require('which-key')

if not wk then
  return
end

local opts = {}

wk.setup(opts)
