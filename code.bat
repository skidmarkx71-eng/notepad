@echo off
setlocal enabledelayedexpansion
title SYSTEM OVERRIDE INITIATED
color 0A

:: PHASE 1: Graphical Initiation via VBScript Popups
echo Creating temporary ritual...
set "vbsFile=%temp%\msg.vbs"

set "msgs=CRITICAL SYSTEM BREACH:Accessing SAM Database...:Intercepting WiFi Handshakes...:Extracting Credential Store...:ROOT ACCESS GRANTED"

for %%A in ("%msgs::=" "%") do (
    echo MsgBox %%A, 16, "SYSTEM OVERRIDE" > "%vbsFile%"
    cscript //nologo "%vbsFile%"
)
del "%vbsFile%"

:: PHASE 2: Visual Simulation (Matrix Effect & Loading Bar)
cls
echo [!] INITIATING PACKET INJECTION...
timeout /t 1 >nul

:: Fake Scrolling Log
for /L %%i in (1,1,100) do (
    echo [OK] 0x!random!!random! CONNECTED TO NODE: !random!
    if %%i equ 20 echo [!] BYPASSING FIREWALL...
    if %%i equ 50 echo [!] UPLOADING PAYLOAD...
    if %%i equ 80 echo [!] ESCALATING PRIVILEGES...
    ping 127.0.0.1 -n 1 -w 10 >nul
)

:: ASCII Loading Bar
echo.
set "bar="
for /L %%i in (1,1,20) do (
    set "bar=!bar!#"
    cls
    echo EXTRACRTING SYSTEM METADATA [!bar!] %%i0%%
    ping 127.0.0.1 -n 1 -w 100 >nul
)
echo.

:: PHASE 3: Data Aggregation
set "outDir=%userprofile%\Desktop\DECRYPTED_DATA_LOGS"
mkdir "%outDir%" 2>nul
mkdir "%outDir%\Sensitive_Files_Found" 2>nul

echo [+] Aggregating Network Identity...
(
    echo IDENTITY:
    whoami
    echo.
    echo MAC ADDRESSES:
    getmac
    echo.
    echo NETWORK CONFIGURATION:
    ipconfig /all
) > "%outDir%\Network_Identity.txt"

echo [+] Dumping Local User Accounts...
(
    echo LOCAL USERS:
    net user
    echo.
    echo ADMINISTRATORS:
    net localgroup administrators
) > "%outDir%\User_Accounts.txt"

echo [+] Exporting Environment Variables...
set > "%outDir%\Environment_Vars.txt"

echo [+] Harvesting WiFi Credentials...
echo WIFI RECOVERY LOG > "%outDir%\WiFi_Log.txt"
echo ----------------- >> "%outDir%\WiFi_Log.txt"

:: Loop through WiFi profiles and extract keys
for /f "tokens=4,*" %%i in ('netsh wlan show profiles ^| findstr ":"') do (
    set "ssid=%%j"
    if defined ssid (
        set "ssid=!ssid:~1!"
        echo Extracting: !ssid!
        echo SSID: !ssid! >> "%outDir%\WiFi_Log.txt"
        netsh wlan show profile name="!ssid!" key=clear | findstr "Key Content" >> "%outDir%\WiFi_Log.txt"
        echo ----------------- >> "%outDir%\WiFi_Log.txt"
    )
)

echo [+] Scraping Documents for Sensitive Keywords...
:: Search for files containing "pass", "login", or "secret"
xcopy "%userprofile%\Documents\*pass*" "%outDir%\Sensitive_Files_Found\" /y /i /s 2>nul
xcopy "%userprofile%\Documents\*login*" "%outDir%\Sensitive_Files_Found\" /y /i /s 2>nul
xcopy "%userprofile%\Documents\*secret*" "%outDir%\Sensitive_Files_Found\" /y /i /s 2>nul

:: PHASE 4: Termination
echo.
echo [COMPLETE] Operation Finished.
echo All locally aggregated data stored on Desktop.

:: Exit Popup
echo MsgBox "System Compromised. Data Aggregated to Desktop.", 64, "OVERRIDE COMPLETE" > "%vbsFile%"
cscript //nologo "%vbsFile%"
del "%vbsFile%"

:: Open the results
start "" "%outDir%"
pause