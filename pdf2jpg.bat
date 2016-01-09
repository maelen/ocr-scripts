@echo on

"C:\Program Files (x86)\gs\gs9.05\bin\gswin32c.exe" -dBATCH -dNOPAUSE -sDEVICE=jpeg -r144 -sOutputFile="%~dpn1_%%02d.jpg" %1

pause