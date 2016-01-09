@echo on
setlocal enabledelayedexpansion enableextensions

%~d1
REM This script expects a folder
cd "%~dpn1"
mkdir out1

set tempString=

for %%F in (*.jpg *.png) do set "tempString=!tempString! %%F"
set "tempString=%tempString:~1%"

echo Preparing scanned images
REM Adjust with page layout --orientation=left
"C:\Program Files\Scan Tailor\scantailor-cli.exe" -v --content-detection=cautious --orientation=left --margins=5 --alignment-vertical=top --alignment-horizontal=center --white-margins=true --output-project=mjb.scantailor %tempString% out1

cd "out1"
REM if exist ..\book.html del ..\book.html
echo Cleaning previous book file
if exist ..\book.txt del ..\book.txt

echo Converting scanned pages to text
copy "C:\Program Files (x86)\Tesseract-OCR\tessdata\configs\hocr" .
for %%F in (*.tif) do (
  "C:\Program Files (x86)\Tesseract-OCR\tesseract" "%%F" "tesseract-out-temp" -l fra +hocr
  "C:\Python27\python.exe" "%~dpn0.py" tesseract-out-temp.html >> ..\book.txt
)

echo Deleting temporary files
cd ..
REM rmdir /s /q out1

REM Convert text to text with calibre (Removes unwanted hyphens)

REM Search for "(?<!((\.|\?|!|—) ))(P|F)([aeiou])" Replace with "l'\4" ("l'" misreads)
REM Spell Checker
pause
pause