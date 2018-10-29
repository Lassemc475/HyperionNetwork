@echo off

:: CONFIGURATION

TITLE GTA 5 FIVEM SERVER
set reboot=20
set reboot_done=0
set location=C:\Users\lasse\Documents\GitHub\ByHyperionFX\

:: CONFIGURATION

:start

set dat=%date:~6,4%-%date:~3,2%-%date:~0,2%
set backup=%location%logs\%dat%.txt

:: Partie sauvegarde

echo [%time%] - Serveur ouvert
echo [%time%] - Serveur ouvert >> %backup%
echo [%time%] - Lancement de la sauvegarde 
echo [%time%] - Lancement de la sauvegarde >> %backup%
xcopy %location%\"resources" %location%\backups\"%dat%" /E /H /R /Y /I /D  >> %backup%
echo [%time%] - Sauvegarde termine
echo [%time%] - Sauvegarde termine >> %backup%

:: Partie sauvegarde

:: Partie lancement

start %location%PolitiServer.bat +exec server.cfg %*

:: Partie lancement

goto loop

:loop
timeout /t 30>null
set tps=%TIME:~-0,2%
    if %tps% == %reboot% (
        if %reboot_done% == 0 (
            echo [%time%] - On ferme le serveur pour reboot && echo [%time%] - On ferme le serveur pour reboot >> %backup%
            taskkill /IM cmd.exe /FI "WINDOWTITLE ne GTA 5 FIVEM SERVER*" >> %backup%
			echo ----------------------------------------------------------------------
            set reboot_done=1
            goto start
        ) else (
            goto loop
        )
    ) else (
        set reboot_done=0
        goto loop
    )