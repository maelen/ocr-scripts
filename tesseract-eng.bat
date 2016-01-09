@echo on

"C:\Program Files (x86)\Tesseract-OCR\tesseract" %1 "%~dpn1" -l eng
REM -i %1 2> %1.txt
REM pause
