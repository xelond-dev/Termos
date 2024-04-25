@echo off
title Termux Updater
setlocal enabledelayedexpansion

:UpdateMark
where git >nul 2>&1
if %errorlevel% equ 0 (
    echo Git is installed on this system.
    

    for /f %%i in ('git diff origin/main') do set diff_output=%%i

    if "%diff_output%"=="" (
        echo Already up to date.
    ) else (
        echo Updating..
        git pull
        echo Updated successfully.
        timeout /t 5
    )

    pause
) else (
    echo Git is not installed on this system.

    set aski=
    set /p aski=Do you want install git for Termux Updater ^(Y\n^)? 

    if "!aski!"=="y" (
        echo "Installing git.."
        echo.

        if not exist "git-install.exe" (
            :: Download git installer
            curl -o git-install.exe -L https://github.com/git-for-windows/git/releases/download/v2.45.0-rc0.windows.1/Git-2.45.0-rc0-64-bit.exe
        )
        
        start /wait git-install.exe
        del git-install.exe

        cls
        goto UpdateMark
    ) else (
        echo Declined.
        timeout /t 5
    )
)
