@echo off
@title RP Server #1
:iniServer
echo.
echo Hyperion Network
echo https://byhyperion.net
echo.
echo.
echo Initiating Server 1 [Port:30120]
echo %date%
echo.
echo %time% : Searching for Cache...
rmdir /S /Q cache
timeout /t 2 >nul
echo %time% : Cache Cleared!
echo %time% : Launching Server
FXServer +set citizen_dir %~dp0\citizen\ +exec serverp.cfg +set sv_LicenseKey 4qf630g8oedn2vc57owc6xnuyt9ri471
echo %time% : Server was shut down..
timeout /t 2 >nul
echo %time% : Attempting to restart server...
timeout /t 3 >nul
echo.
goto iniServer