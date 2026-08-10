' run-hidden.vbs -- run a PowerShell script with zero visible console window
'
' PowerShell's own -WindowStyle Hidden does not reliably suppress the brief
' console flash when launched from Task Scheduler (a known Windows behavior).
' Routing the launch through WScript.Shell.Run with window style 0 does.
'
' Usage:
'   wscript.exe //B run-hidden.vbs "<path to pwsh.exe or powershell.exe>" "<path to .ps1 script>"

Dim objShell, psExe, scriptPath, cmd

Set objShell = CreateObject("WScript.Shell")

psExe = WScript.Arguments(0)
scriptPath = WScript.Arguments(1)

cmd = """" & psExe & """ -NoProfile -ExecutionPolicy Bypass -File """ & scriptPath & """"

' 0 = hidden window, True = wait for the script to finish before this exits
objShell.Run cmd, 0, True
