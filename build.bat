@echo off
cls
"pawncc/builder.py" "./src/" "./Anticheat.pwn"
echo.
echo.
"pawncc/pawncc.exe" "Anticheat_test.pwn" -; -( -l
"pawncc/pawncc.exe" "Anticheat_test.pwn" -; -( -d3
pause