@echo off
cls
"pawncc/builder.py" "./src/" "./Anticheat.inc"
copy "./Anticheat.inc" "./pawncc/include/"
pause