@echo off
setlocal enableextensions

goto desktop

:draw_desktop
cls
echo.
echo  +--------------------------------------------------------------+
echo  ^| FreeDOS GUI 1.0                                 [ _ ][^#][X] ^|
echo  +--------------------------------------------------------------+
echo  ^|                                                              ^|
echo  ^|   [Notepad]        [Command Prompt]        [File Explorer]    ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  ^|                                                              ^|
echo  +--------------------------------------------------------------+
echo  ^| [Start]                                                      ^|
echo  +--------------------------------------------------------------+
echo.
goto :eof

:desktop
call :draw_desktop
echo Start Menu:
echo   1. Notepad
echo   2. Command Prompt
echo   3. File Explorer
echo   4. Reboot
set /p fdosgui_choice=Select an option (1-4):
if "%fdosgui_choice%"=="1" goto notepad
if "%fdosgui_choice%"=="2" goto cmd
if "%fdosgui_choice%"=="3" goto explorer
if "%fdosgui_choice%"=="4" goto reboot

goto desktop

:notepad
cls
echo Launching Notepad...
if exist \edit.exe (
  edit
) else if exist \bin\edit.exe (
  \bin\edit.exe
) else if exist \edlin.exe (
  edlin
) else if exist \bin\edlin.exe (
  \bin\edlin.exe
) else (
  echo No editor found. Please install EDIT or EDLIN.
  pause
)
goto desktop

:cmd
cls
echo Command Prompt - type EXIT to return to the desktop.
command.com
goto desktop

:explorer
cls
call explore.bat
goto desktop

:reboot
cls
echo Rebooting...
if exist \bin\reboot.com (
  \bin\reboot.com
) else (
  echo Press Ctrl+Alt+Del to reboot.
  pause
)
endlocal
