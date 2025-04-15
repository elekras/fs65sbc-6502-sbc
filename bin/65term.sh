#!/bin/sh
# 65term - fs65sbc utility - open putty serial terminal
# uasge: 65term
# by Fabio Sturman (c) 2019,2025
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3
TIME=`date +"%Y%m%d-%H%M%S"`
BAUD=`65baud`
SPORT=`lsserial "FT232R USB UART"`
SPAR="${BAUD},8,n,1,R"
FONS=20
putty -title 6502-${SPORT}-${SPAR} -log ~/log/putty-6502-${TIME}.log -sl 20000 -serial -sercfg ${SPAR} -fn terminus-bold-${FONS} ${SPORT}

