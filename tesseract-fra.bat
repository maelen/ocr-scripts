@echo on

"C:\Program Files (x86)\Tesseract-OCR\tesseract" %1 "%~dpn1" -l fra
REM -i %1 2> %1.txt
pause
