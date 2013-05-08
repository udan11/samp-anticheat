@echo off
REM Cleaning.
del /q /f crashinfo.txt
del /q /f *_log.txt
cd filterscripts/
del /q /f *.amx
cd ../
cd gamemodes/
del /q /f *.amx
cd ../
cls
REM Building filterscripts.
for /f %%f in ('dir /b filterscripts') do (
	"../pawncc/pawncc.exe" "filterscripts/%%f" -; -( -d3
	echo.
	echo.
)
REM Building gamemode.
for /f %%f in ('dir /b gamemodes') do (
	"../pawncc/pawncc.exe" "gamemodes/%%f" -; -( -d3
	echo.
	echo.
)
pause