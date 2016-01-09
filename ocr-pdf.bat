c:
cd "%~dp1"
copy "C:\Program Files (x86)\Tesseract-OCR\tessdata\configs\hocr" .
if exist book.html del book.html
if exist book.txt del book.txt
for /R %%F in (*.tif) do (
  "C:\Program Files (x86)\Tesseract-OCR\tesseract" "%%F" "tesseract-out-temp" -l fra +hocr
  "C:\Python27\python.exe" "%~dpn0.py" tesseract-out-temp.html >> book.txt
)