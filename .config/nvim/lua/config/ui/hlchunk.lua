local utils = require 'rc.utils'

local hlchunk = utils.safe_require 'hlchunk'

if not hlchunk then
  return
end

-- Config
local config = {}

hlchunk.setup(config)
