@echo off

%~d1
cd %1
for %%G in (*.chm) do (
   if not exist "%%~dpnG.epub" (
      echo
      echo Found %%G
      "C:\Program Files (x86)\Calibre2\ebook-convert.exe" "%%G" "%%~dpnG.epub" --flow-size=450
   )
)
pause