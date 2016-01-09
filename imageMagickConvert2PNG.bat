@echo off

"C:\Program Files\ImageMagick-6.7.9-Q16\convert.exe" %1 -resize 200%% "%~dpn1.png"

REM pause