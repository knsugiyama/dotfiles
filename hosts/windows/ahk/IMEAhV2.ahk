#Requires AutoHotkey v2.0

;============================
; 内部ヘルパー：対象HWNDを取得
;============================
_GetTargetHwnd(WinTitle:="A") {
    hwnd := WinExist(WinTitle)
    if WinActive(WinTitle) {
        cbSize := 4 + 4 + (A_PtrSize*6) + 16  ; GUITHREADINFO size (x86:48, x64:72)
        st := Buffer(cbSize, 0)
        NumPut("uint", cbSize, st, 0)
        if DllCall("user32\GetGUIThreadInfo", "uint", 0, "ptr", st, "int")
            hwnd := NumGet(st, 8 + A_PtrSize, "ptr")  ; hwndFocus
    }
    return hwnd
}

;============================
; IME ON/OFF 取得
; 戻り値: 1=ON / 0=OFF
;============================
IME_GET(WinTitle:="A") {
    hwnd := _GetTargetHwnd(WinTitle)
    ime := DllCall("imm32\ImmGetDefaultIMEWnd", "ptr", hwnd, "ptr")
    return DllCall("user32\SendMessageW"
        , "ptr",  ime
        , "uint", 0x0283            ; WM_IME_CONTROL
        , "uptr", 0x0005            ; IMC_GETOPENSTATUS
        , "ptr",  0
        , "ptr")
}

;============================
; IME ON/OFF セット
; 引数: SetSts 1=ON / 0=OFF
; 戻り: 0=成功（IME 依存で非0が返る場合あり）
;============================
IME_SET(SetSts, WinTitle:="A") {
    hwnd := _GetTargetHwnd(WinTitle)
    ime := DllCall("imm32\ImmGetDefaultIMEWnd", "ptr", hwnd, "ptr")
    return DllCall("user32\SendMessageW"
        , "ptr",  ime
        , "uint", 0x0283            ; WM_IME_CONTROL
        , "uptr", 0x0006            ; IMC_SETOPENSTATUS
        , "uptr", SetSts
        , "ptr")
}

;============================
; 変換モード 取得（WM_IME_CONTROL 版）
; 戻り: モード値
;============================
IME_GetConvMode(WinTitle:="A") {
    hwnd := _GetTargetHwnd(WinTitle)
    ime := DllCall("imm32\ImmGetDefaultIMEWnd", "ptr", hwnd, "ptr")
    return DllCall("user32\SendMessageW"
        , "ptr",  ime
        , "uint", 0x0283            ; WM_IME_CONTROL
        , "uptr", 0x0001            ; IMC_GETCONVERSIONMODE
        , "ptr",  0
        , "ptr")
}

;============================
; 変換モード 取得（IMM32 直呼び・フォールバック用）
; 戻り: {conv:UInt, sent:UInt} 取得失敗時は ""
;============================
IME_GetConvMode_IMM(WinTitle:="A") {
    hwnd := _GetTargetHwnd(WinTitle)
    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if !himc
        return ""
    conv := 0, sent := 0
    ok := DllCall("imm32\ImmGetConversionStatus", "ptr", himc, "uint*", conv, "uint*", sent, "int")
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
    return ok ? {conv: conv, sent: sent} : ""
}

;============================
; 現在の HKL を取得（KLID/言語判定用）
;============================
Get_Keyboard_Layout(WinTitle:="A")  {
    hwnd := WinExist(WinTitle)
    tid := DllCall("user32\GetWindowThreadProcessId", "ptr", hwnd, "uint*", 0, "uint")
    return DllCall("user32\GetKeyboardLayout", "uint", tid, "uptr")
}

;=== 言語ID（下位16bit）/ Primary / Sub のヘルパ ===
Get_language_id(hKL) {
    return Format("0x{:X}", hKL & 0xFFFF)
}
Get_primary_language_identifier(local_identifier){
    return Format("0x{:X}", local_identifier & 0xFF)
}
Get_sublanguage_identifier(local_identifier){
    return Format("0x{:X}", (local_identifier >> 8) & 0xFF)
}