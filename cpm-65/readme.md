# This is my port of CPM-65 by Dietrich Lausberg  
# https://github.com/dietrich-l to fs65sbc (work in progress...)  

To build the system on PC I change BIOS.ASM, BDOS.ASM, CCP.ASM to  
assemble under LINUX using xa cross assembler (Andre Fachat). Under  
DEBIAN install xa with "apt install xa65".  
The files where renamed as ccp.xa65, bdos.xa65 and bios.xa65.  
The last file depends on monitor m65 (#include ../../m65.i). The  
Makefile generates ccp.hex, bdos.hex and bios.hex which are uploaded  
to fs65sbc and and m65 jumps to $d600 starting cpm.  
The CPM-65 map is:  
- CCP  at 0xca00 (1Kib)  
- BDOS at 0xce00 (2KiB)  
- BIOS at 0xd600 (2KiB)  

