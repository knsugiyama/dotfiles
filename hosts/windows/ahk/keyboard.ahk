#Requires AutoHotkey v2.0
#SingleInstance Force

SendMode "Input"

;================================================================
; 設定
;================================================================
global DEBUG_LOG   := true                ; ログ出力の有無
global REMAP_MODE  := "auto"              ; "auto"=外部キーボード接続時のみ / "always"=常時 / "never"=無効
global IME_TIMEOUT := 150                 ; IME 制御メッセージのタイムアウト(ms)

; 「外付けではない」とみなすデバイス名のパターン（内蔵キーボード・疑似デバイス）
global INTERNAL_KBD_PATTERNS := ["ACPI#", "ROOT#", "RDP_KBD"]

; 特定の外付けキーボードだけを対象にしたい場合はここに VID/PID を書く
;   例: "VID_045E&PID_0800"　　Ctrl+Alt+K でデバイス名を確認できる
global EXTERNAL_KBD_FILTER := ""

; Alt 単押しでリボンのキーヒントモード（Alt→H→... 等）を使いたいアプリ。
; ここに列挙した実行ファイルがアクティブな間は、Alt 単押しの IME 切替用
; ダミーキー送出をスキップし、素の Alt イベントを通す（後述コメント参照）。
global ALT_MENU_APPS := ["EXCEL.EXE", "WINWORD.EXE", "POWERPNT.EXE", "OUTLOOK.EXE"]

;================================================================
; 状態変数
;================================================================
global g_HasExternalKbd := false          ; 外部キーボード接続フラグ
global g_IsJIS          := false          ; 現在の入力レイアウトが JIS 系か
global g_RemapOn        := false          ; リマップを有効にするか（#HotIf 用）
global g_Hkl            := 0              ; 現在の HKL
global g_LayoutFile     := ""             ; レイアウト DLL 名（参考情報）
global g_LogFile        := ""             ; 実際に書き込めているログのパス

;================================================================
; 初期化
;================================================================
InitLog()
Log("=========== 起動 ===========")
Log("AHK " A_AhkVersion " / " (A_PtrSize = 8 ? "64bit" : "32bit") " / " A_ScriptFullPath)
Log("GetKeyboardType(0)=" DllCall("user32\GetKeyboardType", "int", 0, "int")
  . " (7=日本語キーボードドライバ, 4=101/102英語系)")

UpdateLayout(true)
UpdateKbdStatus(true)

SetTimer UpdateLayout, 500
SetTimer UpdateKbdStatus, 3000
OnMessage(0x0219, OnDeviceChange)         ; WM_DEVICECHANGE

TrayTip (g_LogFile != "" ? "ログ: " g_LogFile : "ログを書き込めません（Ctrl+Alt+K で詳細）"), "keyboard.ahk"

OnDeviceChange(*) {
    SetTimer(() => UpdateKbdStatus(), -800)
}

;================================================================
; 左右 Alt キーの空打ちで IME を切り替える
;
;   {vkFF}（未使用の仮想キー）を Alt と一緒に送っているのは、
;   Windows が「Alt が単独で down→up された」と検知してメニュー／
;   リボンのキーヒントモードに入るのを防ぐため。これを送らないと
;   IME 切替とメニュー起動が同時に発生してしまう。
;   ただし ALT_MENU_APPS に挙げたアプリ（Excel 等）では、逆に
;   このキーヒントモードを使いたいので、その間だけ送出をスキップして
;   素の Alt イベントを通す。IME 切替判定（下の *Alt Up::）は
;   A_PriorHotkey を見ているだけなので、ここで送出を止めても
;   影響を受けない。
;================================================================
#HotIf !WinActive("ahk_exe msrdc.exe")

~LAlt:: {
    if !IsAltMenuApp()
        Send "{Blind}{vkFF}"
}
~RAlt:: {
    if !IsAltMenuApp()
        Send "{Blind}{vkFF}"
}

LAlt Up:: {                               ; 左 Alt：OFF
    if (A_PriorHotkey == "~LAlt" && A_TimeSincePriorHotkey < 400) {
        if !IME_SET(0)
            Send "{vk1Dsc07B}"
    }
}

RAlt Up:: {                               ; 右 Alt：ON
    if (A_PriorHotkey == "~RAlt" && A_TimeSincePriorHotkey < 400) {
        if !IME_SET(1)
            Send "{vk1Csc079}"
    }
}

#HotIf

IsAltMenuApp() {
    global ALT_MENU_APPS
    for exe in ALT_MENU_APPS
        if WinActive("ahk_exe " exe)
            return true
    return false
}

;================================================================
; JIS 配列キーボードを US 配列風にするためのキーリマップ
;================================================================
#HotIf g_RemapOn

; --- 数字段 ---
sc029::   Send "{``}"    ; 半角/全角        [半/全] -> `
+sc029::  Send "{~}"     ; Shift + 半角/全角        -> ~
+sc003::  Send "{@}"     ; Shift + 2        ["]     -> @
+sc007::  Send "{^}"     ; Shift + 6        [&]     -> ^
+sc008::  Send "{&}"     ; Shift + 7        [']     -> &
+sc009::  Send "{*}"     ; Shift + 8        [(]     -> *
+sc00A::  Send "{(}"     ; Shift + 9        [)]     -> (
+sc00B::  Send "{)}"     ; Shift + 0        [ ]     -> )
+sc00C::  Send "{_}"     ; Shift + -        [=]     -> _
sc00D::   Send "{=}"     ; ^ キー           [^]     -> =
+sc00D::  Send "{+}"     ; Shift + ^        [~]     -> +

; --- Q 段 ---
sc01A::   Send "{[}"     ; @ キー           [@]     -> [
+sc01A::  Send "{{}"     ; Shift + @        [`]     -> {
sc01B::   Send "{]}"     ; [ キー           [[]     -> ]
+sc01B::  Send "{}}"     ; Shift + [        [{]     -> }

; --- A 段 ---
+sc027::  Send "{:}"     ; Shift + ;        [+]     -> :
sc028::   Send "{'}"     ; : キー           [:]     -> '
+sc028::  Send '{"}'     ; Shift + :        [*]     -> "

; --- Z 段 ---
sc02B::   Send "{\}"     ; ] キー           []]     -> \
+sc02B::  Send "{|}"     ; Shift + ]        [}]     -> |

#HotIf

;================================================================
; 診断用ホットキー
;================================================================
; 現在の状態を表示
^!k:: {
    MsgBox ListKeyboards()
        . "`n----------------------------------------"
        . "`n外部キーボード判定 : " (g_HasExternalKbd ? "あり" : "なし")
        . "`n動作モード         : " REMAP_MODE
        . "`nリマップ           : " (g_RemapOn ? "有効" : "無効")
        . "`nJIS 配列判定       : " (g_IsJIS ? "はい" : "いいえ")
        . "`nHKL                : " Format("{:08X}", g_Hkl & 0xFFFFFFFF)
        . "`nレイアウトDLL      : " (g_LayoutFile = "" ? "(取得できず)" : g_LayoutFile)
        . "`nキーボードドライバ : " DllCall("user32\GetKeyboardType", "int", 0, "int") " (7=日本語)"
        . "`nログ               : " (g_LogFile = "" ? "書き込み不可" : g_LogFile)
        , "キーボード状態", "Iconi"
}

; 動作モードを切り替える（auto → always → never → auto）
^!u:: {
    global REMAP_MODE
    REMAP_MODE := (REMAP_MODE = "auto") ? "always" : (REMAP_MODE = "always") ? "never" : "auto"
    Log("モード変更: " REMAP_MODE)
    RefreshRemapState(true)
    TrayTip "モード: " REMAP_MODE " / リマップ " (g_RemapOn ? "有効" : "無効"), "keyboard.ahk"
}

; 実際に届いているスキャンコードを確認する（キー履歴ウィンドウ）
^!h:: KeyHistory()

;================================================================
; リマップ有効／無効の再計算
;================================================================
RefreshRemapState(force := false) {
    global g_RemapOn, g_IsJIS, g_HasExternalKbd, REMAP_MODE
    newState := g_IsJIS && (REMAP_MODE = "always"
                        || (REMAP_MODE = "auto" && g_HasExternalKbd))
    if (force || g_RemapOn != newState) {
        g_RemapOn := newState
        Log("リマップ " (newState ? "有効" : "無効")
          . " (JIS=" (g_IsJIS ? "Y" : "N")
          . " 外部KBD=" (g_HasExternalKbd ? "Y" : "N")
          . " モード=" REMAP_MODE ")")
    }
}

;================================================================
; 外部キーボードの状態をチェックして変数を更新する
;================================================================
UpdateKbdStatus(force := false) {
    global g_HasExternalKbd
    newState := DetectExternalKeyboard()
    if (force || g_HasExternalKbd != newState) {
        g_HasExternalKbd := newState
        if force {
            for name in EnumKeyboardNames()
                Log("KBD: " name)
        }
        Log("外部キーボード " (newState ? "あり" : "なし"))
        RefreshRemapState()
    }
}

;================================================================
; Raw Input でキーボードを列挙して外付けの有無を判定する
;================================================================
DetectExternalKeyboard() {
    global INTERNAL_KBD_PATTERNS, EXTERNAL_KBD_FILTER
    for name in EnumKeyboardNames() {
        if (EXTERNAL_KBD_FILTER != "") {
            if InStr(name, EXTERNAL_KBD_FILTER)
                return true
            continue
        }
        isInternal := false
        for pat in INTERNAL_KBD_PATTERNS {
            if InStr(name, pat) {
                isInternal := true
                break
            }
        }
        if !isInternal
            return true
    }
    return false
}

;================================================================
; 接続中のキーボードのデバイス名を配列で返す
;================================================================
EnumKeyboardNames() {
    static RIM_TYPEKEYBOARD := 1, RIDI_DEVICENAME := 0x20000007
    names := []
    sz := A_PtrSize * 2                   ; RAWINPUTDEVICELIST のサイズ

    n := 0
    if (DllCall("GetRawInputDeviceList", "ptr", 0, "uint*", &n, "uint", sz, "int") = -1 || n = 0)
        return names

    buf := Buffer(sz * n, 0)
    got := DllCall("GetRawInputDeviceList", "ptr", buf, "uint*", &n, "uint", sz, "int")
    if (got = -1)
        return names

    Loop got {
        off := (A_Index - 1) * sz
        if (NumGet(buf, off + A_PtrSize, "uint") != RIM_TYPEKEYBOARD)
            continue
        hDev := NumGet(buf, off, "ptr")

        cch := 0
        DllCall("GetRawInputDeviceInfoW", "ptr", hDev, "uint", RIDI_DEVICENAME, "ptr", 0, "uint*", &cch)
        if (cch = 0)
            continue
        nb := Buffer(cch * 2 + 2, 0)
        if (DllCall("GetRawInputDeviceInfoW", "ptr", hDev, "uint", RIDI_DEVICENAME, "ptr", nb, "uint*", &cch) <= 0)
            continue

        name := StrGet(nb, "UTF-16")
        if (name != "")
            names.Push(StrUpper(name))
    }
    return names
}

ListKeyboards() {
    out := "【接続中のキーボード】"
    for name in EnumKeyboardNames()
        out .= "`n・" name
    return out
}

;================================================================
; アクティブウィンドウのキーボードレイアウトを判定する
;================================================================
UpdateLayout(force := false) {
    global g_Hkl, g_IsJIS, g_LayoutFile
    try {
        hwnd := WinExist("A")
        tid  := hwnd ? DllCall("user32\GetWindowThreadProcessId", "ptr", hwnd, "uint*", 0, "uint") : 0
        hkl  := DllCall("user32\GetKeyboardLayout", "uint", tid, "uptr")
        if (!force && hkl = g_Hkl)
            return

        g_Hkl := hkl
        g_IsJIS := IsJisLayout(hkl)
        g_LayoutFile := ResolveLayoutFile(HklToKlid(hkl))
        Log("レイアウト HKL=" Format("{:08X}", hkl & 0xFFFFFFFF)
          . " DLL=" (g_LayoutFile = "" ? "(取得できず)" : g_LayoutFile)
          . " JIS=" (g_IsJIS ? "Y" : "N"))
        RefreshRemapState()
    } catch as e {
        Log("UpdateLayout エラー: " e.Message)
    }
}

;================================================================
; JIS 系レイアウトかどうかを判定する
;   レジストリの Layout File 参照は KLID の解決に失敗することがあるため、
;   「@ が Shift なしで入力できるか」を VkKeyScanEx で直接問い合わせる。
;   JIS: @ = 単独キー(VK_OEM_3) / US: @ = Shift + 2
;================================================================
IsJisLayout(hkl) {
    r := DllCall("user32\VkKeyScanExW", "ushort", 0x40, "ptr", hkl, "short")   ; '@'
    if (r = -1)
        return false
    return ((r >> 8) & 0xFF) = 0          ; 修飾キー不要で '@' が打てる = JIS 系
}

;================================================================
; KLID からレイアウト DLL 名を引く（ログ用の参考情報）
;================================================================
ResolveLayoutFile(klid) {
    base := ""
    try base := RegRead("HKEY_CURRENT_USER\Keyboard Layout\Substitutes", klid)
    if (base != "")
        klid := base

    lf := ""
    try lf := RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\" klid, "Layout File")
    return StrUpper(lf)
}

;================================================================
; ここから IME 制御（旧 IMEAhV2.ahk）
;================================================================
IME_GetTargetHwnd(win := "A") {
    hwnd := WinExist(win)
    if (hwnd && WinActive(win)) {
        cb := 4 + 4 + (A_PtrSize * 6) + 16    ; GUITHREADINFO (x86:48 / x64:72)
        st := Buffer(cb, 0)
        NumPut("uint", cb, st, 0)
        if DllCall("user32\GetGUIThreadInfo", "uint", 0, "ptr", st, "int") {
            focus := NumGet(st, 8 + A_PtrSize, "ptr")   ; hwndFocus
            if focus
                hwnd := focus
        }
    }
    return hwnd
}

IME_Control(hwnd, wParam, lParam, &result) {
    static WM_IME_CONTROL := 0x0283, SMTO_ABORTIFHUNG := 0x0002
    global IME_TIMEOUT
    result := 0
    if !hwnd
        return false
    ime := DllCall("imm32\ImmGetDefaultIMEWnd", "ptr", hwnd, "ptr")
    if !ime
        return false
    res := 0
    ok := DllCall("user32\SendMessageTimeoutW"
        , "ptr",  ime
        , "uint", WM_IME_CONTROL
        , "uptr", wParam
        , "ptr",  lParam
        , "uint", SMTO_ABORTIFHUNG
        , "uint", IME_TIMEOUT
        , "ptr*", &res
        , "ptr")
    if !ok
        return false
    result := res
    return true
}

; 戻り値: 1=ON / 0=OFF / -1=取得失敗
IME_GET(win := "A") {
    static IMC_GETOPENSTATUS := 0x0005
    hwnd := IME_GetTargetHwnd(win)
    if !hwnd
        return -1

    if IME_Control(hwnd, IMC_GETOPENSTATUS, 0, &res)
        return res ? 1 : 0

    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if !himc
        return -1
    open := DllCall("imm32\ImmGetOpenStatus", "ptr", himc, "int")
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
    return open ? 1 : 0
}

; 戻り値: true=設定して反映を確認できた / false=失敗
IME_SET(state, win := "A") {
    static IMC_SETOPENSTATUS := 0x0006
    want := state ? 1 : 0
    hwnd := IME_GetTargetHwnd(win)
    if !hwnd
        return false

    if IME_Control(hwnd, IMC_SETOPENSTATUS, want, &res) {
        if (IME_GET(win) = want)
            return true
    }

    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if !himc
        return false
    DllCall("imm32\ImmSetOpenStatus", "ptr", himc, "int", want, "int")
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
    return IME_GET(win) = want
}

IME_GetConvMode(win := "A") {
    static IMC_GETCONVERSIONMODE := 0x0001
    hwnd := IME_GetTargetHwnd(win)
    if !hwnd
        return -1

    if IME_Control(hwnd, IMC_GETCONVERSIONMODE, 0, &res)
        return res

    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if !himc
        return -1
    conv := 0, sent := 0
    ok := DllCall("imm32\ImmGetConversionStatus", "ptr", himc, "uint*", &conv, "uint*", &sent, "int")
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
    return ok ? conv : -1
}

IME_SetConvMode(mode, win := "A") {
    static IMC_SETCONVERSIONMODE := 0x0002
    hwnd := IME_GetTargetHwnd(win)
    if !hwnd
        return false
    if IME_Control(hwnd, IMC_SETCONVERSIONMODE, mode, &res)
        return IME_GetConvMode(win) = mode
    return false
}

;================================================================
; HKL から KLID（8桁16進）を求める
;   上位ワードが 0xE0xx / 0xF0xx のときは IME 固有 KLID、
;   それ以外は言語ID（下位ワード）から 00000411 のような形にする。
;================================================================
HklToKlid(hkl) {
    lo := hkl & 0xFFFF
    hi := (hkl >> 16) & 0xFFFF
    return ((hi & 0xF000) = 0xE000 || (hi & 0xF000) = 0xF000)
         ? Format("{:08X}", (hi << 16) | lo)
         : Format("{:08X}", lo)
}

;================================================================
; ログ
;   スクリプトと同じフォルダに書けない場合（Program Files 配下、
;   コントロールされたフォルダー アクセスの保護対象など）は
;   一時フォルダへ自動的に切り替える。
;================================================================
InitLog() {
    global g_LogFile, DEBUG_LOG
    if !DEBUG_LOG
        return
    for dir in [A_ScriptDir, A_Temp] {
        f := dir "\keyboard-ahk.log"
        try {
            FileAppend "", f
            if FileExist(f) {
                g_LogFile := f
                return
            }
        }
    }
    g_LogFile := ""                       ; どこにも書けなかった
}

Log(text) {
    global g_LogFile, DEBUG_LOG
    if (!DEBUG_LOG || g_LogFile = "")
        return
    try {
        if (FileGetSize(g_LogFile) > 1048576)
            FileMove g_LogFile, g_LogFile ".bak", true
    }
    try FileAppend FormatTime(, "yyyy-MM-dd HH:mm:ss") ": " text "`n", g_LogFile
}
