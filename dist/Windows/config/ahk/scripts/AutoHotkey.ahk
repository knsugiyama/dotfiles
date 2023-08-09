/*
    左右 Shift キーの空打ちで 入力方式 を切り替える

    左 Shift キーの空打ちで IME を「英語」に切り替え
    右 Shift キーの空打ちで IME を「日本語」に切り替え
    Shift キーを押している間に他のキーを打つと通常の Shift キーとして動作
*/
#UseHook
Persistent
InstallKeybdHook
InstallMouseHook
A_MaxHotkeysPerInterval := 200
SendMode "Input"
SetWorkingDir A_ScriptDir
SetTitleMatchMode 2

#HotIf !WinActive("ahk_exe msrdc.exe") ; remote desktop がアクティブな場合は無効にする。そうしないと ` が入力されてしまう。
; 上部メニューがアクティブになるのを抑制
~LAlt:: Send "{Blind}{vk07}"
~RAlt:: Send "{Blind}{vk07}"

; 直接入力
LAlt Up::
{
    if (A_PriorHotkey == "~LAlt")
    {
        Send "{vkF2sc070B}{vkF3sc029}"
    }
}

; 日本語入力
RAlt Up::
{
    if (A_PriorHotkey == "~RAlt")
    {
        Send "{vkF2sc070B}"
    }
}

; 左Shiftキーが単独で押された場合、IMEをオフにする
; ~LShift Up::
; {
;     if (A_PriorKey = "LShift") {
;         Send "{vkF2sc070}{vkF3sc029}"
;     }
;     Return
; }

; 右Shiftキーが単独で押された場合、IMEをオンにする
; ~RShift Up::
; {
;     if (A_PriorKey = "RShift") {
;         Send "{vkF2sc070}"
;     }
;     Return
; }

#HotIf
