@echo off
@title RP Server #1
:iniServer
echo.
echo Hyperion Network
echo https://byhyperion.net
echo.
echo.
echo Initiating Server 1 [Port:30139]
echo %date%
echo.
echo %time% : Launching Server
FXServer +set citizen_dir %~dp0\citizen\ +exec server1.cfg +set sv_LicenseKey rceib0qi26cq13isw07vto4t7tjomr80
echo %time% : Server was shut down..
timeout /t 2 >nul
echo %time% : Attempting to restart server...
timeout /t 3 >nul
echo.
goto iniServer