/*
    左右 Alt キーの空打ちで 入力方式 を切り替える
    Alt キーを押している間に他のキーを打つと通常の Alt キーとして動作
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
~LAlt:: Send "{Blind}{vkFF}"
~RAlt:: Send "{Blind}{vkFF}"

; 直接入力
LAlt Up::
{
    if (A_PriorHotkey == "~LAlt")
    {
        ; 日本語環境判定 TODO 判定処理がこれで良いかは再考の余地あり
        if (GetKeyName("vkDEsc00D") == "^") {
            Send "{vk1Dsc07B}" ; 無変換
        } else {
            Send "{vkF2sc070}{vkF3sc029}"
        }
    }
}

; 日本語入力
RAlt Up::
{
    if (A_PriorHotkey == "~RAlt")
    {
        ; 日本語環境判定 TODO 判定処理がこれで良いかは再考の余地あり
        if (GetKeyName("vkDEsc00D") == "^") {
            Send "{vk1Csc079}" ; 変換
        } else {
            Send "{vkF2sc070}"
        }
    }
}

#HotIf
