-- Global table to prevent Garbage Collection
-- GCによる予期せぬ動作停止を防ぐため、グローバルなテーブルで管理します
_G.myConfig = _G.myConfig or {}

local log = hs.logger.new("mymodule", "debug")
local map = hs.keycodes.map
local flagsChanged = hs.eventtap.event.types.flagsChanged
local keyDown = hs.eventtap.event.types.keyDown

-- Settings / 設定
-- 事前に hs.keycodes.currentSourceID() を実行して確認した値を入力してください
-- local ID_ABC = "ABC"
-- local ID_SKK = "ひらがな" -- macSKKの実際のID
local ID_ABC = "net.mtgto.inputmethod.macSKK.ascii"
local ID_SKK = "net.mtgto.inputmethod.macSKK.hiragana"
local TIMEOUT_SEC = 0.3 -- これ以上長押しした場合は切り替えない

-- State / 状態
local currentAppName = hs.application.frontmostApplication():name()
local cmdPressedTime = 0
local otherKeyPushed = false

-- App Watcher / アプリ監視
_G.myConfig.appWatcher = hs.application.watcher.new(function(name, event, app)
    if event == hs.application.watcher.activated then
        currentAppName = name
    end
end):start()

-- Event Tap Logic / 入力切替ロジック
_G.myConfig.eikanaEvent = hs.eventtap.new({ flagsChanged, keyDown }, function(event)
    -- 特定のアプリでは処理をバイパス
    if currentAppName == "Alacritty" then return false end

    local type = event:getType()
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()

    -- 他のキーが押されたらフラグを立てる
    if type == keyDown then
        if flags["cmd"] then
            otherKeyPushed = true
        end
        return false
    end

    -- FlagsChanged (Modifier key changed)
    if type == flagsChanged then
        if flags["cmd"] then
            -- Cmd 押下時
            cmdPressedTime = hs.timer.secondsSinceEpoch()
            otherKeyPushed = false
        else
            -- Cmd 離上時
            local duration = hs.timer.secondsSinceEpoch() - cmdPressedTime
            -- 他のキーが押されておらず、かつ長押し（タイムアウト）でない場合のみ実行
            if not otherKeyPushed and duration < TIMEOUT_SEC then
                if keyCode == map["cmd"] then
                    -- 左Cmd -> ABC (英数)
                    if hs.keycodes.currentSourceID() ~= ID_ABC then
                        hs.keycodes.currentSourceID(ID_ABC)
                    end
                elseif keyCode == map["rightcmd"] then
                    -- 右Cmd -> macSKK (日本語)
                    if hs.keycodes.currentSourceID() ~= ID_SKK then
                        hs.keycodes.currentSourceID(ID_SKK)
                    end
                end
            end
            otherKeyPushed = false
        end
    end
    return false
end):start()

-- Esc Key Tap / Escキーで英数に戻す
_G.myConfig.escTap = hs.eventtap.new({ keyDown }, function(event)
    if event:getKeyCode() == map["escape"] then
        log.i(hs.keycodes.currentSourceID())
        -- 既にABCなら何もしない（負荷軽減）
        if hs.keycodes.currentSourceID() ~= ID_ABC then
            hs.keycodes.currentSourceID(ID_ABC)
        end
    end
    return false
end):start()

-- Path Watcher / 設定変更時の自動リロード
local configPath = os.getenv("HOME") .. "/.config/hammerspoon/init.lua"
_G.myConfig.reloader = hs.pathwatcher.new(configPath, function()
    hs.timer.doAfter(0.1, hs.reload)
end):start()

log.i("Hammerspoon configuration loaded with enhanced stability.")