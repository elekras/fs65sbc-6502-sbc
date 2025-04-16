#!/bin/bash
# generate m65.i65, m65.inc or m65.i from m65.lbl
# to use m65 system calls in asm programs
# m65 utilities
# (c) 2019, 25 by Fabio Sturman
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3 
all="jmcld jmwrm jmconr jmconw jmcont jmsdr jmsdw jmsdi jmsdll jmsdlh jmgets jmputs \
     jmputb jmputw jmputsp jmputcl jmrtcr jmrtcw jmpmur jmpmuw  \
     jmi2cini jmi2cstr jmi2cstp jmi2cack jmi2cnak jmi2cwrt jmi2crea jmrinc \
     jmrdec jmradd jmrsub jmrcmp jmrequ jmrzer jmr0 jmsw16 jmtimr jmtbrk jmdhms \
     jmtoupc jmbuz jmcfr jmcfw jmcfi jmcfll jmcflh jmat24r jmat24w jmat24p"

echo "; ****** m65 monitor for fs65sbc *******"
echo "; include file for calling m65 functions"
echo "; by Fabio Sturman  fabio.sturman@gmail.com"
echo "; GNU GENERAL PUBLIC LICENSE Version 3"
QU=$2
if [ "$QU" == "" ]; then
  QU=":="
fi
date=`date "+%H:%M:%S %d.%m.%Y"`
echo "; ${date}" 
for k in $all; do
#  i=`grep "${k}$" m65.lbl`
  i=`grep "${k}$" ${1}`
  #echo $i
  ad=${i:5:4}
  label=${i:11}
  echo $label $QU \$$ad
done
