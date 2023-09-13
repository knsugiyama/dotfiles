local log = hs.logger.new('mymodule', 'debug')
local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local keyUp = hs.eventtap.event.types.keyUp
local flagsChanged = hs.eventtap.event.types.flagsChanged
local eventtap = hs.eventtap

--[[
-- auto reload
--]]
autoReload = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/hammerspoon/init.lua', function()
  hs.timer.doAfter(0.1, hs.reload)
end):start()

--[[
-- 左右Altキーで英語、Google日本語入力を切り替える
--]]
local simpleAlt = false

local function eikanaEvent(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  if event:getType() == keyDown then
    if f['alt'] then
      simpleAlt = true
    end
  elseif event:getType() == flagsChanged then
    if not f['alt'] then
      if simpleAlt == false then
        if c == map['alt'] then
          hs.keycodes.setMethod('Alphanumeric (Google)')
        elseif c == map['rightalt'] then
          hs.keycodes.setMethod('Hiragana (Google)')
        end
      end
      simpleAlt = false
    end
  end
end

eikana = eventtap.new({ keyDown, flagsChanged }, eikanaEvent)
eikana:start()

--[[
-- esc キー押下でIME切り替えをする
--]]
switchToEisuOnEscape = eventtap.new({ keyDown }, function(e)
  if hs.keycodes.map[e:getKeyCode()] == 'escape' then
    hs.keycodes.setMethod('Alphanumeric (Google)')
  end
end):start()

--[[
-- ControlとCommandキーの入れ替えをインターセプトで実現する
--]]
swapCtrlAndCmd = eventtap.new({ keyDown, keyUp }, function(e)
  -- 特定のアプリケーションの名前をチェック
  local focusedApp = hs.application.frontmostApplication()
  log.i(focusedApp:title())

  if focusedApp:name() == "Microsoft Remote Desktop"
      or focusedApp:name() == "WezTerm" then
    -- Controlキーの場合、Commandキーに変換
    local flags = e:getFlags()
    if flags.ctrl and not flags.cmd then
      flags.ctrl = false
      flags.cmd = true
      e:setFlags(flags)
      -- Commandキーの場合、Controlキーに変換
    elseif flags.cmd and not flags.ctrl then
      flags.cmd = false
      flags.ctrl = true
      e:setFlags(flags)
    end
  end
end):start()
