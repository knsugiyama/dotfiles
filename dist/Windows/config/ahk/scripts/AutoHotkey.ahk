/*
    左右 Alt キーの空打ちで 入力方式 を切り替える

    左 Alt キーの空打ちで IME を「英語」に切り替え
    右 Alt キーの空打ちで IME を「日本語」に切り替え
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

Return

; 主要なキーを HotKey に設定し、何もせずパススルーする
*~a::
*~b::
*~c::
*~d::
*~e::
*~f::
*~g::
*~h::
*~i::
*~j::
*~k::
*~l::
*~m::
*~n::
*~o::
*~p::
*~q::
*~r::
*~s::
*~t::
*~u::
*~v::
*~w::
*~x::
*~y::
*~z::
*~1::
*~2::
*~3::
*~4::
*~5::
*~6::
*~7::
*~8::
*~9::
*~0::
*~F1::
*~F2::
*~F3::
*~F4::
*~F5::
*~F6::
*~F7::
*~F8::
*~F9::
*~F10::
*~F11::
*~F12::
*~`::
*~~::
*~!::
*~@::
*~#::
*~$::
*~%::
*~^::
*~&::
*~*::
*~(::
*~)::
*~-::
*~_::
*~=::
*~+::
*~[::
*~{::
*~]::
*~}::
*~\::
*~|::
*~;::
*~'::
*~"::
*~,::
*~<::
*~.::
*~>::
*~/::
*~?::
*~Esc::
*~Tab::
*~Space::
*~Left::
*~Right::
*~Up::
*~Down::
*~Enter::
*~PrintScreen::
*~Delete::
*~Home::
*~End::
*~PgUp::
*~PgDn::

; 上部メニューがアクティブになるのを抑制
*~LAlt:: Send "{Blind}{vk07}"
*~RAlt:: Send "{Blind}{vk07}"

; 直接入力
LAlt Up::
{
    if (A_PriorHotkey == "*~LAlt")
    {
        ; PostMessage 0x0050, 0, 0x4090409, , "A" ; 0x50 is WM_INPUTLANGCHANGEREQUEST
        ; Send "{vkF2sc070B}{vkF3sc029}"
        Send "{vkF3sc029}"
    }
}

; 日本語入力
RAlt Up::
{
    if (A_PriorHotkey == "*~RAlt")
    {
        ; PostMessage 0x0050, 0, 0x4110411, , "A" ; 0x50 is WM_INPUTLANGCHANGEREQUEST ; 0x50 is WM_INPUTLANGCHANGEREQUEST
        Send "{vkF2sc070B}"
    }
}
