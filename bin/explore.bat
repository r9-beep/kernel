@echo off
setlocal enableextensions

goto explorer

:header
cls
echo.
echo  +--------------------------------------------------------------+
echo  ^| File Explorer                                                 ^|
echo  +--------------------------------------------------------------+
echo  ^| Current directory:                                            ^|
echo  +--------------------------------------------------------------+
cd
echo.
goto :eof

:explorer
call :header
dir /w
echo.
echo Options:
echo   1. Change directory
echo   2. View file
echo   3. Up one level
echo   4. Return to desktop
set /p explorer_choice=Select an option (1-4):
if "%explorer_choice%"=="1" goto change_dir
if "%explorer_choice%"=="2" goto view_file
if "%explorer_choice%"=="3" goto up_one
if "%explorer_choice%"=="4" goto done

goto explorer

:change_dir
set /p explorer_dir=Enter directory name:
if "%explorer_dir%"=="" goto explorer
cd %explorer_dir%
if errorlevel 1 (
  echo Directory not found.
  pause
)
goto explorer

:view_file
set /p explorer_file=Enter filename:
if "%explorer_file%"=="" goto explorer
if not exist %explorer_file% (
  echo File not found.
  pause
  goto explorer
)
cls
echo Viewing: %explorer_file%
echo.
type %explorer_file%
echo.
pause
goto explorer

:up_one
cd ..
goto explorer

:done
endlocal
