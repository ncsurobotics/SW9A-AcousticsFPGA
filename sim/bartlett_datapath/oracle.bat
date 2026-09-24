:: @echo off
setlocal enabledelayedexpansion

:: Check if argument was passed
if "%~1"=="" (
    set /p testName=Enter test name: 
) else (
    set "testName=%~1"
)

set "folderName=%testName%"
mkdir "%folderName%"

if "%~2"=="" (
	copy "raw_hydro_data*.csv" "%folderName%\data.csv"
	.\csv_to_hex.exe "%folderName%\data.csv" "%folderName%\data.hex" 32 2147483647
) else (
	copy "%~2" "%folderName%\data.csv"
	.\csv_to_hex.exe "%folderName%\data.csv" "%folderName%\data.hex" 32 2147483647
)

matlab -batch "oracle('%folderName%')"

