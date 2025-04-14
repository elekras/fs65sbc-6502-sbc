# This is my port of CPM-65 by Dietrich Lausberg  
# https://github.com/dietrich-l to fs65sbc (work in progress...)  

To build the system on PC I change BIOS.ASM, BDOS.ASM, CCP.ASM and  
BOOT.ASM using xa cross assembler (Andre Fachat) under    
DEBIAN 12. Install xa with "apt install xa65".  
The files where renamed as ccp.xa65, bdos.xa65, bios.xa65 and boot.xa65.  
Bios and boot depend on monitor m65 (#include ../../m65/m65.i). The  
"make" generates ccp.hex, bdos.hex, bios.hex and boot.hex which are  
uploaded to fs65sbc and and m65 jumps to $d600 starting cpm.  
To save boot and the system on CF or SD card you must first select it  
in Makefile and then "make wboot" to write boot to CF/SD, "make cpm" to  
write system on CF/SD. To start cpm-65 from CF use m65 monitor  
command "o" or "o0" and "o1" for SD card.  
The CPM-65 map is:  
- CCP  at 0xca00 (1Kib)  
- BDOS at 0xce00 (2KiB)  
- BIOS at 0xd600 (2KiB)  
- BOOT at 0x0200 (<256 B)  
BOOT is saved on CF/SD to sector 0  
CPM-65 is saved on CF/SD from sector 1  

