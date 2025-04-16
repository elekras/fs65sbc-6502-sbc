#------------------------------------------------------------------------------
# m65 makefile
# (c) 2019, 25 by Fabio Sturman
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3 
#------------------------------------------------------------------------------
file=m65

files=acia.a65 macros.i65 get_put.a65 interrupt.a65 regs.a65 \
  i2c.a65 tpin.a65 timers.a65 sd_cf.a65 ${HOME}/bin/65baud \
  via0.i65 acia0.i65 m65.cfg sweet16.a65 at24c.a65 vec.a65 ./gi65.sh

EPROM_EMULATOR = memsim2 -d `lsserial MEMSIM2`
BIN2HEX=bin2hex
SBCBAUD=`65baud`
# find port for epromng
NGPORT=`lsserial USB2.0-Serial`
# for arduino nano new boot loader usbc
NGPORTC=`lsserial "USB Serial"`
SPORT=`lsserial "FT232R USB UART"`
TIMEST=`date "+%Y%m%d%H%M%S"`

FILL=./0xff-1KiB.bin
DDSTART=0xDE00
RRSTART=0xE400
RRSIZE=0x1BFA

all: log ${file}.bin load
#all: log ${file}.bin

# write time stamp to log file
log:
		@echo>>${file}.log --------------------------------------------
		@echo>>${file}.log `date +"%Y.%m.%d  %H:%M:%S"`

# convert to hex
${file}.hex: ${file}.bin
		@echo Converting...
		@echo>>${file}.log Converting...
		@${BIN2HEX} --offset 0 ${file}.bin ${file}.hex

# assemble a65
${file}.bin: ${file}.a65 ${file}.cfg ${files}
		@echo Assembling...
		@echo>>${file}.log Assembling...
		@echo Baud=${SBCBAUD}
		@echo>>${file}.log Baud=${SBCBAUD}
		@echo>date.i65 "    .byte \"${TIMEST}\""
		@ca65 ${file}.a65 -o ${file}.o -l ${file}.lst -D BAUD=${SBCBAUD}
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
		@./gi65>${file}.i65 ${file}.lbl ":="   
		@./gi65>${file}.inc ${file}.lbl ".equ" 
		@./gi65>${file}.i ${file}.lbl "=" 

# upload the binary image to eprom emulator
load: log ${file}.bin
		@echo Uploading file to emulator...
		@echo>>${file}.log Uploading file to emulator...
		@cat ${FILL} ${file}.bin >${file}-epr.bin
#		@${EPROM_EMULATOR} -m 2764 -r -100 ${file}-epr.bin
		epromng -spi y -auto y -mem 2764 -map y ${file}-epr.bin ${NGPORT}

# program the flash eprom with minipro
prog: log ${file}.bin
		@echo Bulding 8KiB eprom file...
		@echo>>${file}.log Bulding 8KiB eprom file...
		cat ${FILL} ${file}.bin >${file}-epr.bin
		minipro -p AT28HC64 -w ${file}-epr.bin

# test CF speed
cfspeed: log
		@echo Testing CF speed...
		@echo>>${file}.log Testing CF speed...
		# y = sys timer
		# 1 tick = 20ms
		# 10 x read 96 blocks of 512 b = 10 x 49152 byte = 480 KiB
		# speed = 480 KiB / ((tstart - tend) * 0.02 s)
		# run tspeed to compute speed
		@echo "# Testing CF READ SPEED"  | tr "\n" "\r" >${SPORT}
		@echo "# Total 480KiB memory"    | tr "\n" "\r" >${SPORT}
		@echo "# 1 timer tick 20 ms"     | tr "\n" "\r" >${SPORT}
		@echo "# START CF READ SPEED"    | tr "\n" "\r" >${SPORT}
		@echo "y"                        | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "u 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "# END CF READ SPEED"      | tr "\n" "\r" >${SPORT}
		@echo "y"                        | tr "\n" "\r" >${SPORT}

# test SD speed
sdspeed: log
		@echo Testing SD speed...
		@echo>>${file}.log Testing SD speed...
		# y = sys timer
		# 1 tick = 20ms
		# 10 x read 96 blocks of 512 b = 10 x 49152 byte = 480 KiB
		# speed(KiB/s)  = 480 KiB / ((tstart - tend) * 0.02 s)
		# run tspeed to compute speed
		@echo "# Testing SD READ SPEED"  | tr "\n" "\r" >${SPORT}
		@echo "# Total 480KiB memory"    | tr "\n" "\r" >${SPORT}
		@echo "# 1 timer tick 20 ms"     | tr "\n" "\r" >${SPORT}
		@echo "# START SD READ SPEED"    | tr "\n" "\r" >${SPORT}
		@echo "y"                        | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "l 0, 60, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "# END SD READ SPEED"      | tr "\n" "\r" >${SPORT}
		@echo "y"                        | tr "\n " "\r" >${SPORT}

# test at24c256 speed
at24speed: log
		@echo Testing AT24C256 speed...
		@echo>>${file}.log Testing AT24C256 speed...
		# y = sys timer
		# 1 tick = 20ms
		# 5 x read 384 blocks of 64 b = 5 x 24576 byte = 120 KiB
		# speed(KiB/s)  = 480 KiB / ((tstart - tend) * 0.02 s)
		# run tspeed to compute speed
		@echo "# Testing AT24C256 READ SPEED"  | tr "\n" "\r" >${SPORT}
		@echo "# Total 120KiB memory"    | tr "\n" "\r" >${SPORT}
		@echo "# 1 timer tick 20 ms"     | tr "\n" "\r" >${SPORT}
		@echo "# START AT24C256 READ SPEED"    | tr "\n" "\r" >${SPORT}
		@echo "y"                        | tr "\n" "\r" >${SPORT}
		@echo "q 0, 180, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "q 0, 180, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "q 0, 180, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "q 0, 180, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "q 0, 180, 200" | tr -d " " | tr "\n" "\r" >${SPORT}
		@echo "# END AT24C256 READ SPEED"      | tr "\n" "\r" >${SPORT}
		@echo "y"                        | tr "\n " "\r" >${SPORT}

# clear files
clean: log
		@echo Clearing...
		@echo>>${file}.log Clearing...
		@rm -f *.hex
		@rm -f ${file}.bin ${file}-epr.bin
		@rm -f ${file}.o
		@rm -f ${file}.lbl
		@rm -f ${file}.lbl.sort
		@rm -f ${file}.lst
		@rm -f ${file}.map
		@rm -f ${file}.inc ${file}.i ${file}.i65

