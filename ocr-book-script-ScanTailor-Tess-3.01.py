# encoding: utf-8

import sys
import re
from lxml import etree

char_mDash="\xE2\x80\x94"
char_RdoubleAngleQuotMark="\xc2\xbb"
char_RsingleAngleQuotMark="\xE2\x80\xBA"
char_degreeSign="\xc2\xb0"
char_LdoubleQuotMark="\xE2\x80\x9C"
char_RdoubleQuotMark="\xE2\x80\x9D"

file = sys.argv[1]

tree = etree.parse(file)
# result = etree.tostring(tree.getroot(), pretty_print=True, method="xml")
# print(result)

allPageTextPosition=tree.xpath("/html/body/div/div[@class='ocr_carea']/@title")
for pageTextPosition in allPageTextPosition:
    page = pageTextPosition.getparent()
    pageTextPosition=pageTextPosition.rsplit(" ")
    lines=page.xpath("p/span[@class='ocr_line']")
    for line in lines:
        linePosition=line.xpath("@title")
        linePosition=linePosition[0].rsplit(" ")
        lineStr = ((line.xpath("string()")).encode('utf-8'))
        lineStr = re.sub("~", "-", lineStr)
        lineStr = re.sub("^(-|_|--|_-) ", char_mDash + " ", lineStr)
        lineStr = re.sub(char_RsingleAngleQuotMark+char_RsingleAngleQuotMark,
                         char_RdoubleAngleQuotMark, lineStr)
        lineStr = re.sub("("+
                         char_degreeSign     +"|"+
                         "`"                 +"|"+
                         char_LdoubleQuotMark+"|"+
                         char_RdoubleQuotMark+
                         ")", "'", lineStr)
        lineStr = re.sub("(\w)\?", "\\1 ?", lineStr)
        lineStr = re.sub("(\w)\!", "\\1 !", lineStr)        
        if(not (re.search('^\d+$', lineStr))):
            if(int(linePosition[1])-int(pageTextPosition[1]) > 20):
                print "\n",lineStr
            else:
                print lineStr
    