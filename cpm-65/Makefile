#------------------------------------------------------------------------------
# cpm-65 makefile
# (c) 2025 by Fabio Sturman
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3
#------------------------------------------------------------------------------

# SPORT: USB to serial FT232 adpter connected to fs65sbc
SPORT=`lsserial "FT232R USB UART"`
# LOG file
LOG=cpm-65.log
# options for xa65
OPT=-XMASM -r
# start addres of bios, bdos and ccp
CCP_START=0xca00
BDOS_START=0xce00
BIOS_START=0xd600

all: load

log:
	@echo>>${LOG} --------------------------------------------
	@echo>>${LOG} `date +"Time Stamp: %Y.%m.%d  %H:%M:%S"`
	@echo --------------------------------------------
	@echo `date +"Time Stamp: %Y.%m.%d  %H:%M:%S"`

bios.hex: bios.xa65 ../../m65.i
	@echo>>${LOG} Assembling bios...
	@echo Assembling bios...
	@xa ${OPT} bios.xa65 -o bios.o65 -P bios.lst -e bios.err -l bios.lbl
	@echo>>${LOG} Converting bios...
	@echo Converting bios...
	@bin2hex --offset=${BIOS_START} bios.o65 bios.hex
	
bdos.hex: bdos.xa65
	@echo>>${LOG} Assembling bdos...
	@echo Assembling bdos...
	@xa ${OPT} bdos.xa65 -o bdos.o65 -P bdos.lst -e bdos.err -l bdos.lbl
	@echo>>${LOG} Converting bdos...
	@echo Converting bdos...
	@bin2hex --offset=${BDOS_START} bdos.o65 bdos.hex
	
ccp.hex: ccp.xa65
	@echo>>${LOG} Assembling ccp...
	@echo Assembling ccp...
	@xa ${OPT} ccp.xa65 -o ccp.o65 -P ccp.lst -e ccp.err -l ccp.lbl
	@echo>>${LOG} Converting ccp...
	@echo Converting ccp...
	@bin2hex --offset=${CCP_START} ccp.o65 ccp.hex
	
load: log bios.hex bdos.hex ccp.hex
	@echo>>${LOG} Uploading CPM65...
	@echo Uploading CPM65...
	@echo "# Uploading CPM65..." | tr '\n' '\r' >${SPORT}
	@echo "# bios..." | tr '\n' '\r' >${SPORT}
	@cat bios.hex | tr '\n' '\r' >${SPORT}
	@echo "# bdos..." | tr '\n' '\r' >${SPORT}
	@cat bdos.hex | tr '\n' '\r' >${SPORT}
	@echo "# ccp..." | tr '\n' '\r' >${SPORT}
	@cat ccp.hex  | tr '\n' '\r' >${SPORT}
	@echo "# jump to bios..." | tr '\n' '\r' >${SPORT}
	@echo "jd600" | tr '\n' '\r' >${SPORT}

clean: log
	@echo Clearing...
	@echo>>${LOG} Clearing...
	@rm -f *.hex *.lst *.err *.lbl *.o65
