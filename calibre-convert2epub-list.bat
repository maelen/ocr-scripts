@echo on
pause
echo %*
pause
for %%G IN ("%*") do (
   if not exist "%%~dpnG.epub" (
      echo
      echo Found "%%G"
      "C:\Program Files (x86)\Calibre2\ebook-convert.exe" %%G "%%~dpnG.epub"
   )
)
pause