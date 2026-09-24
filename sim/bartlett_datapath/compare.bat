@echo off
setlocal enabledelayedexpansion

:: Check if argument was passed
if "%~1"=="" (
    set /p testName=Enter test name: 
) else (
    set "testName=%~1"
)


matlab -batch "compare('%testName%')"

