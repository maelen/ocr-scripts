#!/bin/sh

inputfolder="$1"
basepath=$(pwd $(dirname "$1"))
foldername=$(basename "$1")
scriptpath=$(pwd $(dirname "$0"))
#echo Input Folder $inputfolder
#echo Base Path $basepath
#echo Folder Name $foldername

shopt -s nocaseglob

cd "$inputfolder"
[ -e out1 ] && rm -Rf out1
mkdir -p out1

echo Preparing scanned images
scantailor-cli -v --content-detection=cautious --orientation=left --margins=5 --alignment-vertical=top --alignment-horizontal=center --white-margins=true --output-project=mjb.scantailor *.jp*g out1

[ -e $basepath/$foldername.txt ]  && rm $basepath/$foldername.txt

echo Converting scanned pages to text
cd out1
cp /usr/share/tesseract-ocr/tessdata/configs/hocr .
for file in *.tif
do
    tesseract $file tesseract-out-temp -l eng +hocr
    $scriptpath/hocr2txt.py tesseract-out-temp.hocr >> $basepath/$foldername.txt
done
cd ../..
