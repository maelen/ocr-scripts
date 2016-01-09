@echo on

REM copy %~dpn0.scm %HOMEPATH%\.gimp-2.8\scripts
REM set filenameIN=%~dp1*.jpg
REM echo %filenameIN%
REM set filenameIN=%filenameIN:\=\\%

%~d1
cd "%~dp1\out"
copy "C:\Program Files (x86)\Tesseract-OCR\tessdata\configs\hocr" .
if exist ..\book.html del ..\book.html
if exist ..\book.txt del ..\book.txt
for /R %%F in (*.tif) do (
  "C:\Program Files (x86)\Tesseract-OCR\tesseract" "%%F" "tesseract-out-temp" -l fra +hocr
  "C:\Python27\python.exe" "%~dpn0.py" tesseract-out-temp.html >> ..\book.txt
)
REM cd ..
REM rmdir /s /q "%~dp1ocr-book-script-temp"
REM Search for "(?<!((\.|\?|!|—) ))(P|F)([aeiou])" Replace with "l'\4"
REM Convert text to text with calibre (Removes unwanted hyphens)
REM Change oe character
REM Spell Checker

pause
pause