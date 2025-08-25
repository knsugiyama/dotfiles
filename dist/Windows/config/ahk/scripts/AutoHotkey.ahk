;================================================================
; 初期設定 (v2.0 準拠)
;================================================================
#SingleInstance Force
SendMode "Input"

;================================================================
; グローバル変数の準備とタイマーの設定
;================================================================
global HasExternalKbd := false ; 外部キーボードの状態を保存する変数
UpdateKbdStatus()              ; 起動時に一度、状態をチェック
SetTimer UpdateKbdStatus, 5000  ; 5秒（5000ms）ごとに状態をチェックし続ける

;================================================================
; キーボードレイアウト判定
;================================================================
isJISLayout := (DllCall("GetKeyboardLayout", "UInt", DllCall("GetWindowThreadProcessId", "Ptr", WinExist("A"), "UInt",0)) & 0xFFFF) == 0x0411
LogToFile("JISレイアウト判定結果: " . isJISLayout)

;================================================================
; 左右Altキーの空打ちでIMEを切り替える
;================================================================
#HotIf !WinActive("ahk_exe msrdc.exe")

~LAlt:: Send "{Blind}{vkFF}"
~RAlt:: Send "{Blind}{vkFF}"

LAlt Up:: {
    if (A_PriorHotkey == "~LAlt" && A_TimeSincePriorHotkey < 400) {
        Send "{vk1Dsc07B}"
    }
}
RAlt Up:: {
    if (A_PriorHotkey == "~RAlt" && A_TimeSincePriorHotkey < 400) {
        Send "{vk1Csc079}"
    }
}

;================================================================
; JIS配列キーボードをUS配列風にするためのキーリマップ
;================================================================
; isJISLayoutがtrueで、かつ「外部キーボードが接続されている」場合のみ有効にする
#HotIf isJISLayout && HasExternalKbd
; --- 1キー段目 ---
sc029:: Send "{``}"    ; 半角/全角
+sc029:: Send "{~}"
+2:: Send "{@}"       ; Shift + 2         ["] -> @
+6:: Send "{^}"       ; Shift + 6         [&] -> ^
+7:: Send "{&}"       ; Shift + 7         ['] -> &
+8:: Send "{*}"       ; Shift + 8         [(] -> *
+9:: Send "{(}"       ; Shift + 9         [)] -> (
+0:: Send "{)}"       ; Shift + 0         [ ] -> ),
+-:: Send "{_}"       ; Shift + -         [=] -> _
^:: Send "{=}"        ;                   [^] -> =
+^:: Send "{+}"       ; Shift + ^         [~] -> +

; Qキー段目
@:: Send "{[}"        ;                   [@] -> [
+@:: Send "{{}"       ; Shift + @         [`] -> {
[:: Send "{]}"        ;                   [[] -> ]
+[:: Send "{}}"       ; Shift + [         [{] -> }

; Aキー段目
+;:: Send "{:}"       ; Shift + ;         [+] -> :
::: Send "{'}"        ;                   [:] -> '
*:: Send '{"}'        ; Shift + :         [*] -> "

; --- Zキー段目 ---
+]:: Send "{|}"       ; Shift + ]         [}] -> |
]:: Send "{\}"        ;                   []] -> \

; すべてのHotIf条件をリセット
#HotIf

;================================================================
; 外部キーボードの状態をチェックして変数を更新する関数
;================================================================
UpdateKbdStatus() {
    try {
        wmi := ComObjGet("winmgmts:")
        keyboards := wmi.ExecQuery("SELECT * FROM Win32_Keyboard")

        ; 以前の状態と変化があった場合のみログを記録
        if (HasExternalKbd != (keyboards.Count > 2)) {
            global HasExternalKbd := keyboards.Count > 2
            LogToFile("キーボード状態更新: 外部キーボード " . (HasExternalKbd ? "あり" : "なし"))
        }
    } catch
        return
}

;================================================================
; ログをファイルに書き出すための関数
;================================================================
LogToFile(LogText) {
    LogFile := A_ScriptDir . "\debug.log"
    Timestamp := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    FileAppend Timestamp . ": " . LogText . "`n", LogFile
}
