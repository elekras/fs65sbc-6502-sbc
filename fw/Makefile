#------------------------------------------------------------------------------
# fsm65 makefile
# (c) 2019, 21 by Fabio Sturman
# fabio.sturman@gmail.com
#------------------------------------------------------------------------------
file=m65
curdir=`pwd`
cc65="/home/program/data/documents/6502/cc65-master"
files=acia.a65 macros.i65 get_put.a65 interrupt.a65 regs.a65 \
  i2c.a65 tpin.a65 timers.a65 sd_cf.a65 /home/program/bin/65baud \
  via0.i65 acia0.i65 m65.cfg sweet16.a65 at24c.a65 ./util/gi65.sh

EPROM_EMULATOR = /home/program/bin/memsim2 -d `/home/program/bin/find-memsim2.py`
BIN2HEX=/usr/share/python3-intelhex/bin2hex.py
SBCBAUD=`/home/program/bin/65baud`
# find port for epromng
NGPORT=`lsserial USB2.0-Serial`
# for arduino nano usbc
NGPORTC=`lsserial "USB Serial"`

# ROMS = rom size 6 or 7 KiB
ROMS=7
ifeq "${ROMS}" "7"
	FILL=./util/0xff-9KiB.bin
	DDSTART=0xDE00
	RRSTART=0xE400
	RRSIZE=0x1BFA
endif
ifeq "${ROMS}" "6"
	FILL=./util/0xff-10KiB.bin
	DDSTART=0xE200
	RRSTART=0xE800
	RRSIZE=0x17FA
endif


#all: log ${file}.hex ${file}.bin load
all: log ${file}.bin load
full: clean ${file}.hex ${file}.bin load lib

log:
		@echo>>${file}.log --------------------------------------------
		@echo>>${file}.log `date +"%Y.%m.%d  %H:%M:%S"`

${file}.hex: ${file}.bin
		@echo Converting...
		@echo>>${file}.log Converting...
		@${BIN2HEX} --offset 0 ${file}.bin ${file}.hex

${file}.bin: ${file}.a65 ${file}.cfg ${files}
		@echo Assembling...
		@echo>>${file}.log Assembling...
		@echo Baud=${SBCBAUD}
		@echo>>${file}.log Baud=${SBCBAUD}
		@ca65 ${file}.a65 -o ${file}.o -l ${file}.lst -D BAUD=${SBCBAUD} \
		-D ROMS=${ROMS}
		@echo Linking...
		@echo>>${file}.log Linking...
		@ld65 -C ${file}.cfg ${file}.o -m ${file}.map -o ${file}.bin \
		-Ln ${file}.lbl -D DSTART=${DDSTART} -D RSTART=${RRSTART} \
		-D RSIZE=${RRSIZE}
		@echo Sorting labels...
		@echo>>${file}.log Sorting labels...
		@sort<${file}.lbl >${file}.lbl.sort 
		@echo "Generating ${file}.i65, ${file}.inc, ${file}.i..."
		@echo>>${file}.log "Generating ${file}.i65, ${file}.inc, ${file}.i..."
		@util/gi65.sh>${file}.i65 ${file}.lbl ":="   
		@util/gi65.sh>${file}.inc ${file}.lbl ".equ" 
		@util/gi65.sh>${file}.i ${file}.lbl "=" 

# load the binary image to memsim2
load: log
		@echo Uploading file to emulator...
		@echo>>${file}.log Uploading file to emulator...
		@cat ${FILL} ${file}.bin >${file}-epr.bin
#		@${EPROM_EMULATOR} -m 27128 -r -100 ${file}-epr.bin
		epromng -spi y -auto y -mem 27128 -map y ${file}-epr.bin ${NGPORTC}

lib: log
		@echo Recompiling cc65 lib...
		@echo>>${file}.log Recompiling cc65 lib...
		@cd ${cc65} 1>/dev/null; ./buildlib;

# program the flash eprom with minipro
prog: log
		@echo Bulding 8KiB eprom file...
		@echo>>${file}.log Bulding 8KiB eprom file...
		cat util/0xff-1KiB.bin ${file}.bin >${file}-8KiB.bin
		minipro -p AT28HC64 -w ${file}-8KiB.bin
		

clean: log
		@echo Clearing...
		@echo>>${file}.log Clearing...
		@rm -f ${file}.hex
		@rm -f ${file}.bin
		@rm -f ${file}.o
		@rm -f ${file}.lbl
		@rm -f ${file}.lbl.sort
		@rm -f ${file}.lst
		@rm -f ${file}.map
		@rm -f ${file}.inc
		
