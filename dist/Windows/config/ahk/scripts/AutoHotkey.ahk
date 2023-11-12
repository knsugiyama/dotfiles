/*
    左右 Alt キーの空打ちで 入力方式 を切り替える
    Alt キーを押している間に他のキーを打つと通常の Alt キーとして動作
*/

; + -> Shift
; ^ -> Control
; ! -> Alt
; # -> Win
; & -> 同時押し

#UseHook
A_MaxHotkeysPerInterval := 200
Persistent ; スクリプトを常駐
InstallKeybdHook ; キーボードフックを有効化
InstallMouseHook ; マウスフックを有効化
SendMode "Input" ; SendコマンドのモードをInputにする(処理速度向上のため)
SetWorkingDir A_ScriptDir ; 作業フォルダをAutoHotkey.ahkを含むフォルダとする
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
            ImeOff()
        }
    }

    ; 日本語入力
    RAlt Up::
    {
        if (A_PriorHotkey == "~RAlt")
        {
            ImeOn()
        }
    }
#HotIf

#HotIf WinActive("ahk_exe firefox.exe")
    || WinActive("ahk_exe edge.exe")
    || WinActive("ahk_exe notion.exe")
    ^h:: Send "{ Left }"
    ^j:: Send "{ Down }"
    ^k:: Send "{ Up }"
    ^l:: Send "{ Right }"
    ^u:: Send "{ Home }" ;行頭へ
    ^o:: Send "{ End }" ;行末へ
#HotIf

#HotIf WinActive("ahk_exe obsidian.exe")
    || WinActive("ahk_exe wezterm.exe")

    Esc::
    {
        ImeOff()
        Send "{Esc}"
    }

    ^c::
    {
        ImeOff()
        Send "{Esc}"
    }

    ^[::
    {
        ImeOff()
        Send "{Esc}"
    }
#HotIf

;=============================================
; 内部関数
;=============================================
ImeOn() {
    ; 日本語環境判定 TODO 判定処理がこれで良いかは再考の余地あり
    if (GetKeyName("vkDEsc00D") == "^") {
        Send "{vk1Csc079}" ; 変換
    } else {
        Send "{vkF2sc070}"
    }
}

ImeOff() {
    ; 日本語環境判定 TODO 判定処理がこれで良いかは再考の余地あり
    if (GetKeyName("vkDEsc00D") == "^") {
        Send "{vk1Dsc07B}" ; 無変換
    } else {
        Send "{vkF2sc070}{vkF3sc029}"
    }
}
