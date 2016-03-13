#!/usr/bin/python

# encoding: utf-8

import sys
import re
from lxml import etree

char_LdoubleAngleQuotMark="\xC2\xAB"
char_RdoubleAngleQuotMark="\xC2\xBB"
char_degreeSign="\xC2\xB0"
char_latinSmallLigatureOE="\xC5\x93"
char_RsingleAngleQuotMark="\xE2\x80\xBA"
char_mDash="\xE2\x80\x94"
char_LdoubleQuotMark="\xE2\x80\x9C"
char_RdoubleQuotMark="\xE2\x80\x9D"
char_latinSmallLigatureFI="\xEF\xAC\x81"
char_latinSmallLigatureFL="\xEF\xAC\x82"

file = sys.argv[1]

tree = etree.parse(file)
# result = etree.tostring(tree.getroot(), pretty_print=True, method="xml")
# print(result)

allPageTextCoord=tree.xpath("/ns:html/ns:body/ns:div/ns:div[@class='ocr_carea']/@title",namespaces={'ns': 'http://www.w3.org/1999/xhtml'})
pageTextPosition=None
for pageTextCoord in allPageTextCoord:
    page = pageTextCoord.getparent()
    pageTextPositionTemp=int((pageTextCoord.rsplit(" "))[1])
    if(pageTextPosition == None or pageTextPositionTemp<pageTextPosition):
       pageTextPosition=pageTextPositionTemp
       
for pageTextCoord in allPageTextCoord:
    page = pageTextCoord.getparent()
    lines=page.xpath("ns:p/ns:span[@class='ocr_line']",namespaces={'ns': 'http://www.w3.org/1999/xhtml'})
    for line in lines:
        lineCoord=line.xpath("@title")
        linePosition=(lineCoord[0].rsplit(" "))[1]
        lineStr = ((line.xpath("string()")).encode('utf-8'))
        lineStr = lineStr.rstrip()
        lineStr = re.sub("~", "-", lineStr)
        lineStr = re.sub("^(-|_|--|_-) ", char_mDash + " ", lineStr)
        lineStr = re.sub("^("+char_mDash+")+",char_mDash,lineStr)
        lineStr = re.sub("<<",
                       char_LdoubleAngleQuotMark, lineStr)
        lineStr = re.sub(">>",
                       char_RdoubleAngleQuotMark, lineStr)
        lineStr = re.sub(char_latinSmallLigatureFI,
                       "fi", lineStr)
        lineStr = re.sub(char_latinSmallLigatureFL,
                       "fl", lineStr)
        lineStr = re.sub(char_latinSmallLigatureOE,
                       "oe", lineStr)
        lineStr = re.sub("("+
                         char_degreeSign     +"|"+
                         "`"                 +"|"+
                         char_LdoubleQuotMark+"|"+
                         char_RdoubleQuotMark+
                         ")", "'", lineStr)
        lineStr = re.sub("(\w)\s+\?", "\\1?", lineStr)
        lineStr = re.sub("(\w)\s+\!", "\\1!", lineStr)

        if(not(re.search('\-$', lineStr))):
          lineStr = lineStr + " "
        lineStr = re.sub('\-$', "", lineStr)
        if(not(re.search('^\s*\d+\s*$', lineStr))):
            if(int(linePosition)-int(pageTextPosition) > 20):
                sys.stdout.write("\n\n"+lineStr)
            else:
                 sys.stdout.write(lineStr)
    
