@echo off

"C:\Program Files (x86)\gs\gs9.05\bin\gswin32c.exe" -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile="%~dp1out.pdf" %*

pause