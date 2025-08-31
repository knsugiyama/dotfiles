@echo off

setlocal ENABLEDELAYEDEXPANSION

set START_BREKETIME="13:00:00.00"
set END_BREKETIME="14:00:00.00"
set STOPTIME="18:00:00.00"
set SHUTDOWNTIME="19:00:00.00"
set LOOPTIME=120

:working_time_loop
    echo working_time
    echo %DATE% %TIME%
    cscript pressKey.vbs
    timeout /t %LOOPTIME% > nul

    if "!TIME!" gtr %STOPTIME% (
        goto :waiting_shutdown_loop
    ) else if "!TIME!" geq %START_BREKETIME% if "!TIME!" leq %END_BREKETIME% (
        goto :break_time_loop
    )
goto :working_time_loop

:break_time_loop
    echo break_time
    echo %DATE% %TIME%
    timeout /t %LOOPTIME% > nul

    if "!TIME!" geq %END_BREKETIME% (
        goto :working_time_loop
    )
goto :break_time_loop

:waiting_shutdown_loop
    echo shutdown_time
    echo %DATE% %TIME%
    timeout /t %LOOPTIME% > nul

    if "!TIME!" gtr %SHUTDOWNTIME% (
        goto :end
    )
goto :waiting_shutdown_loop

:end
echo Shutting down the system...
rem shutdown /s /t 180
