#Requires AutoHotkey v2.0
#include .\IMEAhV2.ahk
;================================================================
; 初期設定 (v2.0 準拠)
;================================================================
#SingleInstance Force
SendMode "Input"

;================================================================
; グローバル変数の準備とタイマーの設定
;================================================================
global HasExternalKbd := false         ; 外部キーボード接続フラグ
global g_LayoutFile   := ""            ; >>> 現在のレイアウトDLL名（大文字）
CacheLayout()                           ; >>> 起動時に一度キャッシュ
UpdateKbdStatus()                       ; 起動時に一度、状態チェック
SetTimer UpdateKbdStatus, 5000          ; 5秒ごとにキーボード有無をチェック

; >>> 入力言語変更を拾ってレイアウトを更新（WM_INPUTLANGCHANGE = 0x51）
OnMessage(0x51, (*) => CacheLayout())

;================================================================
; 左右Altキーの空打ちでIMEを切り替える
;================================================================
#HotIf !WinActive("ahk_exe msrdc.exe")

~LAlt:: Send "{Blind}{vkFF}"
~RAlt:: Send "{Blind}{vkFF}"

LAlt Up:: {
    ; 直前のホットキーが LAlt で、かつ押下から400ms以内＝単押し判定
    if (A_PriorHotkey == "~LAlt" && A_TimeSincePriorHotkey < 400) {
        if !SetIme(0) {                ; IMM32で失敗したらフォールバック
            Send "{vk1Dsc07B}"         ; ← 既存の切替キー送信
        }
    }
}

; 右Alt：ON
RAlt Up:: {
    if (A_PriorHotkey == "~RAlt" && A_TimeSincePriorHotkey < 400) {
        if !SetIme(1) {
            Send "{vk1Csc079}"
        }
    }
}

;================================================================
; JIS配列キーボードをUS配列風にするためのキーリマップ
;================================================================
; >>> “関数呼び出し”に変更：常に最新判定を使う
#HotIf IsJISLayout() && HasExternalKbd
; --- 1キー段目 ---
sc029:: Send "{``}"    ; 半角/全角
+sc029:: Send "{~}"
+2:: Send "{@}"        ; Shift + 2         ["] -> @
+6:: Send "{^}"        ; Shift + 6         [&] -> ^
+7:: Send "{&}"        ; Shift + 7         ['] -> &
+8:: Send "{*}"        ; Shift + 8         [(] -> *
+9:: Send "{(}"        ; Shift + 9         [)] -> (
+0:: Send "{)}"        ; Shift + 0         [ ] -> ),
+-:: Send "{_}"        ; Shift + -         [=] -> _
^:: Send "{=}"         ;                   [^] -> =
+^:: Send "{+}"        ; Shift + ^         [~] -> +

; Qキー段目
@:: Send "{[}"         ;                   [@] -> [
+@:: Send "{{}"        ; Shift + @         [`] -> {
[:: Send "{]}"         ;                   [[] -> ]
+[:: Send "{}}"        ; Shift + [         [{] -> }

; Aキー段目
+;:: Send "{:}"        ; Shift + ;         [+] -> :
::: Send "{'}"         ;                   [:] -> '
*:: Send '{"}'         ; Shift + :         [*] -> "

; --- Zキー段目 ---
+]:: Send "{|}"        ; Shift + ]         [}] -> |
]:: Send "{\}"         ;                   []] -> \

; 条件をリセット
#HotIf

;================================================================
; レイアウトDLLをキャッシュする（アクティブウィンドウのスレッド対象）
;================================================================
CacheLayout(win := "A") {
    global g_LayoutFile
    try {
        hwnd := WinExist(win)
        ; GetWindowThreadProcessId(HWND, LPDWORD) → threadId を受け取る
        tid := DllCall("GetWindowThreadProcessId", "ptr", hwnd, "uint*", 0, "uint")
        ; GetKeyboardLayout(DWORD) → HKL（ポインタサイズ）を返す
        hkl := DllCall("GetKeyboardLayout", "uint", tid, "uptr") ; HKL
        ; HKL の下位32bitを KLID として 8桁16進へ（例：00000411）
        klid := Format("{:08X}", hkl & 0xFFFFFFFF)

        ; IME固有HKLは Substitutes で基本KLIDへ置換（ある場合のみ）
        base := ""
        try base := RegRead("HKEY_CURRENT_USER\\Keyboard Layout\\Substitutes", klid)
        if (base != "")
            klid := base

        ; KLID→レジストリで Layout File を引く
        layoutFile := ""
        try layoutFile := RegRead(
            "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Keyboard Layouts\\" klid,
            "Layout File"
        )

        g_LayoutFile := StrUpper(layoutFile)
        if (g_LayoutFile != "")
            LogToFile("LayoutFile: " . g_LayoutFile)
    } catch {
        g_LayoutFile := ""
    }
}

;================================================================
; JIS配列（106/109系）かを判定
;================================================================
IsJISLayout(win := "A") {
    global g_LayoutFile
    if (g_LayoutFile = "")
        CacheLayout(win)
    if (g_LayoutFile = "")
        return false  ; 判定不能時は安全側

    ; よく使われる日本語レイアウトDLL（例：KBDJPN.DLL, KBD106.DLL, KBD106N.DLL）
    return RegExMatch(g_LayoutFile, "KBDJPN\.DLL|KBD106(?:N)?\.DLL")
}

;================================================================
; 外部キーボードの状態をチェックして変数を更新する関数
;================================================================
UpdateKbdStatus() {
    global HasExternalKbd
    try {
        wmi := ComObjGet("winmgmts:")
        keyboards := wmi.ExecQuery("SELECT * FROM Win32_Keyboard")
        ; 2台以上あれば“外付けあり”とみなす（内蔵+外付けの想定）
        newState := (keyboards.Count > 1)
        if (HasExternalKbd != newState) {
            HasExternalKbd := newState
            LogToFile("キーボード状態更新: 外部キーボード " . (HasExternalKbd ? "あり" : "なし"))
        }
    } catch
        return
}

;================================================================
; IME ON/OFF の トグル
;================================================================
SetIme(onOff, win:="A") {
    try {
        IME_SET(onOff, win)          ; IMM32 経由でON/OFF
        return IME_GET(win) == onOff ; 念のため検証
    } catch {
        return false
    }
}

;================================================================
; ログをファイルに書き出すための関数
;================================================================
LogToFile(LogText) {
    LogFile := A_ScriptDir . "\debug.log"
    Timestamp := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    FileAppend Timestamp . ": " . LogText . "`n", LogFile
}