@echo off
:: Define the path to your Node.js versions folder
set NODE_DIR=C:\Users\gsatyasa070422\bin
set VERSION_FILE=%USERPROFILE%\last-node-version.txt

:: Check if a version was saved previously
if exist "%VERSION_FILE%" (
    set /p selected_path=<"%VERSION_FILE%"
    echo Using previously selected Node.js version: %selected_path%
) else (
    call :chooseVersion
)

:: Add the selected version to the PATH
set PATH=%selected_path%;%PATH%
echo Node.js version set to %selected_path%.
node -v

:: Ask if the user wants to switch the version
set /p switch=Do you want to switch Node.js version? (y/n): 
if /i "%switch%"=="y" (
    call :chooseVersion
)

:: Keep terminal open
echo Press any key to exit...
pause
exit /b

:chooseVersion
:: List available versions and prompt user to select one
setlocal enabledelayedexpansion
set count=0

echo Available Node.js versions:
for /d %%D in ("%NODE_DIR%\node-v*-win-x64") do (
    set /a count+=1
    set "version[!count!]=%%~nxD"
    echo !count!. %%~nxD
)

if %count%==0 (
    echo No Node.js versions found in %NODE_DIR%.
    pause
    exit /b
)

set /p choice=Enter the number of the Node.js version to use: 
if %choice% gtr %count% (
    echo Invalid choice. Exiting...
    pause
    exit /b
)

set "selected=!version[%choice%]!"
set "selected_path=%NODE_DIR%\%selected%"

:: Save the selected version to a file
echo %selected_path% > "%VERSION_FILE%"
echo Selected version saved: %selected_path%.
exit /b
