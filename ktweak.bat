@echo off
if not "%~1"=="AM_ADMIN" (
    powershell -Command "Start-Process '%~f0' -Verb RunAs -ArgumentList 'AM_ADMIN'"
    exit /b
)

REM Set the code page to UTF-8 for proper character rendering
chcp 65001 >nul
REM Set font to Lucida Console (a monospaced font that supports ASCII art)
reg add "HKCU\Console" /v "FaceName" /d "Lucida Console" /f >nul
reg add "HKCU\Console" /v "FontFamily" /t REG_DWORD /d 0x00000036 /f >nul
reg add "HKCU\Console" /v "FontSize" /t REG_DWORD /d 0x00100000 /f >nul

color 0B
:menu
cls
echo.
echo  ██╗  ██╗████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗
echo  ██║ ██╔╝╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝
echo  █████╔╝    ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ 
echo  ██╔═██╗    ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ 
echo  ██║  ██╗   ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗
echo  ╚═╝  ╚═╝   ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ - by karsten
echo.
echo.
echo.
echo  Performance
echo.
echo  [1] Clear temporary files
echo  [2] Clear recycle bin
echo.
echo  Network Speed
echo.
echo  [3] Flush DNS cache
echo  [4] Update DNS servers
echo.
echo  Windows Tweaks
echo.
echo  [5] Clear Windows Update Cache
echo  [6] Clear Prefetch Files
echo  [7] Stop Unnecessary Services
echo  [8] Clear Event Logs
echo  [9] Scan for and Repair System Files
echo.
echo  [X] Exit
echo.
choice /c 123456789X /n /m "Enter your choice (1-9, X for 10): "
set choice=%errorlevel%

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto option3
if "%choice%"=="4" goto option4
if "%choice%"=="5" goto option5
if "%choice%"=="6" goto option6
if "%choice%"=="7" goto option7
if "%choice%"=="8" goto option8
if "%choice%"=="9" goto option9
if "%choice%"=="10" goto option10
goto menu

:option1
echo Clearing temporary files...
del /q/f/s "%TEMP%\*" 2>nul
del /q/f/s "%WINDIR%\Temp\*" 2>nul
del /q/f/s "%WINDIR%\Prefetch\*" 2>nul
del /q/f/s "%SYSTEMROOT%\Temp\*" 2>nul
echo Temporary files cleared successfully.
timeout /t 2 >nul
goto menu


:option2
echo Clearing Recycle Bin...
rd /s /q "%USERPROFILE%\Desktop\$Recycle.bin"
rd /s /q "%SYSTEMDRIVE%\$Recycle.bin"
rd /s /q "%USERPROFILE%\$Recycle.bin"
echo Recycle Bin cleared successfully.
timeout /t 2 >nul
goto menu

:option3
echo Flushing DNS Cache...
ipconfig /flushdns
echo DNS Cache cleared successfully.
timeout /t 2 >nul
goto menu

:option4
echo Changing DNS servers to Cloudflare (1.1.1.1 and 1.0.0.1)...
netsh interface ip set dns "Ethernet" static 1.1.1.1 primary
netsh interface ip add dns "Ethernet" 1.0.0.1 index=2
netsh interface ip set dns "Wi-Fi" static 1.1.1.1 primary
netsh interface ip add dns "Wi-Fi" 1.0.0.1 index=2
echo DNS servers updated successfully.
timeout /t 2 >nul
goto menu

:option5
echo Stopping Windows Update service...
net stop wuauserv
net stop bits

echo Clearing Windows Update cache...
rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution"
mkdir "%SYSTEMROOT%\SoftwareDistribution"

echo Restarting Windows Update service...
net start bits
net start wuauserv

echo Windows Update cache cleared successfully.
timeout /t 2 >nul
goto menu

:option6
echo Clearing Prefetch files...
del /q/f/s "%WINDIR%\Prefetch\*" 2>nul
echo Prefetch files cleared successfully.
timeout /t 2 >nul
goto menu

:option7
echo Stopping unnecessary services...
net stop "Windows Search"
net stop "Superfetch"
net stop "Windows Defender Network Inspection"
net stop "Windows Defender Security Center"
net stop "Windows Defender Service"
net stop "DiagTrack"
net stop "WerSvc"
net stop "PcaSvc"
net stop "WSearch"
net stop "MapsBroker"
net stop "SysMain"

echo Unnecessary services stopped successfully.
timeout /t 2 >nul
goto menu

:option8
echo Clearing System Event Logs...
wevtutil cl System
wevtutil cl Application
wevtutil cl Security
echo Event Logs cleared successfully.
timeout /t 2 >nul
goto menu

:option9
echo Scanning and Repairing System Files...
echo Running System File Checker...
sfc /scannow

echo Running DISM to repair Windows image...
DISM /Online /Cleanup-Image /RestoreHealth

echo System file repair process completed.
echo Please restart your computer to complete repairs.
timeout /t 5 >nul
goto menu

:option10
echo Are you sure you want to exit? (Y/N)
choice /c YN
if %errorlevel% == 1 exit
if %errorlevel% == 2 goto menu