local simpleAlt = false
local map = hs.keycodes.map

-- 左右Altキーで英語、Google日本語入力を切り替える
local function eikanaEvent(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  if event:getType() == hs.eventtap.event.types.keyDown then
    if f['alt'] then
      simpleAlt = true
    end
  elseif event:getType() == hs.eventtap.event.types.flagsChanged then
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

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()
