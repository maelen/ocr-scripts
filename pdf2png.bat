@echo on

::"C:\Program Files\ImageMagick-6.7.9-Q16\convert.exe" -density 300 -colorspace RGB %1 +adjoin "%~dpn1_%%02d.png"
"C:\Program Files (x86)\gs\gs9.05\bin\gswin32c.exe" -dBATCH -dNOPAUSE -sDEVICE=pngalpha -r300 -sOutputFile="%~dpn1_%%02d.png" %1