#!/bin/bash
# sendsbc - fs65sbc utility - send file to smc
# usage: sendsbc <file>
# by Fabio Sturman (c) 2019,2025
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3 
SPORT=`lsserial "FT232R USB UART"`
printf "Sending file...\n"
if [ "$SPORT" == "" ] ; then
  printf "No com port!\n"
  exit 1
fi
if [ "$1" == "" ] ; then
  printf "No file!\n"
  exit 2
fi
cat $1 | tr '\n' '\r' | tee $SPORT

