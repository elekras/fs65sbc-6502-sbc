#!/bin/bash
# set rtc on fs65sbc
# sends "i<time> <date>\r"
# on serial port
# GNU GENERAL PUBLIC LICENSE Version 3
printf "Setting time on fs65sbc...\n"
PORT=`lsserial "FT232R USB UART"`
TD=`date +"%H:%M:%S %d.%m.%Y"`
if [ "$PORT" == "" ]
then
  printf "No com port!\n"
  exit
fi
printf "Setting time: %s on %s\n" "${TD}" ${PORT}
echo "i${TD}" | tr '\n' '\r' >$PORT