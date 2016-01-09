@echo on

copy %~dpn0.scm %HOMEPATH%\.gimp-2.8\scripts
set filenameIN=%~dp1*.jpg
echo %filenameIN%
set filenameIN=%filenameIN:\=\\%
REM set filenameOUT=%~dpn1-out%
REM set filenameOUT=%filenameOUT:\=\\%
set width=2380
set height=2020
set offsetX=890
set offsetY=480
set xposition=1130
set lowThreshold=172

"C:\Program Files\GIMP 2\bin\gimp-2.8" -i -b "(ocr-book-script \"%filenameIN%\" %width% %height% %offsetX% %offsetY% %xposition% %lowThreshold%) (gimp-quit 0)"
mkdir "%~dp1ocr-book-script-temp"
move /-y "%~dp1*-1.jpg" "%~dp1ocr-book-script-temp"
move /-y "%~dp1*-2.jpg" "%~dp1ocr-book-script-temp"
C:
cd "%~dp1ocr-book-script-temp"
copy "C:\Program Files (x86)\Tesseract-OCR\tessdata\configs\hocr" .
if exist ..\book.html del ..\book.html
if exist ..\book.txt del ..\book.txt
for /R %%F in (*.jpg) do (
  "C:\Program Files (x86)\Tesseract-OCR\tesseract" "%%F" "tesseract-out-temp" -l fra +hocr
  "C:\Python27\python.exe" "%~dpn0.py" tesseract-out-temp.html >> ..\book.txt
)
cd ..
rmdir /s /q "%~dp1ocr-book-script-temp"
REM Search for "(?<!((\.|\?|!|—) ))(P|F)([aeiou])" Replace with "l'\4"
REM Convert text to text with calibre (Removes unwanted hyphens)
REM Change oe character
REM Spell Checker

pause
pause