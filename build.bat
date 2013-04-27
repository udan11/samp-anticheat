@echo off
cls
"pawncc/builder.py" "./src/" "./pawncc/include/Anticheat.inc"
echo.
echo ---- Compiling gamemode -------------------------------------------------------
"pawncc/pawncc.exe" "test-server/gamemodes/test.pwn" -; -( -l
"pawncc/pawncc.exe" "test-server/gamemodes/test.pwn" -; -( -d3
echo.
echo ---- Compiling filterscripts --------------------------------------------------
"pawncc/pawncc.exe" "test-server/filterscripts/test.pwn" -; -( -l
"pawncc/pawncc.exe" "test-server/filterscripts/test.pwn" -; -( -d3
pause