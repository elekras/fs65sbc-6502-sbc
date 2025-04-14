#-----------------------------------------------------------------------
# CPM-65 makefile
# (c) 2025 by Fabio Sturman
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3
#-----------------------------------------------------------------------

# SPORT: USB to serial FT232 adpter connected to fs65sbc
SPORT=`lsserial "FT232R USB UART"`
# LOG file
LOG=cpm-65.log
# options for xa65
OPT=-XMASM -r
# start addres of bios, bdos and ccp
boot_START=0x0200
ccp_START=0xca00
bdos_START=0xce00
bios_START=0xd600

# CF or SD card selection
CARD=CF
SC=V

# for SD card uncomment, comment for CF
CARD=SD
SC=S

HEXS=ccp.hex bdos.hex bios.hex boot.hex 

all: log lcpm run

log:
	@echo>>$(LOG) --------------------------------------------
	@echo>>$(LOG) `date +"Time Stamp: %Y.%m.%d  %H:%M:%S"`
	@echo --------------------------------------------
	@echo `date +"Time Stamp: %Y.%m.%d  %H:%M:%S"`

boot.hex: boot.xa65 ../../m65/m65.i ./card.xi65
bios.hex: bios.xa65 ../../m65/m65.i ./card.xi65
$(HEXS): %.hex: %.xa65
	@echo>>$(LOG) Assembling $*...
	@echo Assembling $*...
	@xa $(OPT) $< -o $*.o65 -P $*.lst -e $*.err -l $*.lbl
	@echo>>$(LOG) Converting $* to hex @$($(*)_START)...
	@echo Converting $* to hex @$($(*)_START)...
	@bin2hex --offset=$($(*)_START) $*.o65 $*.hex

card.xi65:
	@echo>>$(LOG) Generating card.xi65...
	@echo Generating card.xi65...
	@echo>card.xi65  "SD	= 0"
	@echo>>card.xi65 "CF	= 1"
	@echo>>card.xi65 "CARD	= ${CARD}"

lboot: $(HEXS)
	@echo>>${LOG} Uploading BOOT...
	@echo Uploading BOOT...
	@echo "# boot..." | tr '\n' '\r' >${SPORT}
	@cat boot.hex  | tr '\n' '\r' >${SPORT}

wboot: lboot
	@echo>>${LOG} Writing boot to $(CARD)...
	@echo Writing boot to $(CARD)...
	@echo "# save boot to sec 0..." | tr '\n' '\r' >${SPORT}
	@echo "$(SC)0,1,200" | tr '\n' '\r' >${SPORT}

lcpm: $(HEXS)
	@echo>>${LOG} Uploading CPM-65...
	@echo Uploading CPM-65...
	@echo "# Uploading CPM65..." | tr '\n' '\r' >${SPORT}
	@echo "# bios..." | tr '\n' '\r' >${SPORT}
	@cat bios.hex | tr '\n' '\r' >${SPORT}
	@echo "# bdos..." | tr '\n' '\r' >${SPORT}
	@cat bdos.hex | tr '\n' '\r' >${SPORT}
	@echo "# ccp..." | tr '\n' '\r' >${SPORT}
	@cat ccp.hex  | tr '\n' '\r' >${SPORT}

wcpm: lcpm
	@echo>>${LOG} Writing CPM-65 to $(CARD)...
	@echo Writing CPM-65 to $(CARD)...
	@echo "# writing CPM-65 to $(CARD)..." | tr '\n' '\r' >${SPORT}
	@echo "$(SC)1,1,ca00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)2,1,cb00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)3,1,cc00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)4,1,cd00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)5,1,ce00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)6,1,cf00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)7,1,d000" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)8,1,d100" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)9,1,d200" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)a,1,d300" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)b,1,d400" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)c,1,d500" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)d,1,d600" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)e,1,d700" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)f,1,d800" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)10,1,d900" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)11,1,da00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)12,1,db00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)13,1,dc00" | tr '\n' '\r' >${SPORT}
	@echo "$(SC)13,1,dd00" | tr '\n' '\r' >${SPORT}

run:
	@echo>>${LOG} Jumping to CPM-65...
	@echo Jumping to CPM-65...
	@echo "# jump to CPM..." | tr '\n' '\r' >${SPORT}
	@echo "j$(bios_START)" | sed s/0x// | tr '\n' '\r' >${SPORT}

clean: log
	@echo Clearing...
	@echo>>${LOG} Clearing...
	@rm -f *.hex *.lst *.err *.lbl *.o65 card.xi65
