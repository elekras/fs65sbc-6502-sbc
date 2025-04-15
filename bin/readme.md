# PC utilities for FS65SBC and M65  
  
This are PC utilities for my FS65SBC and monitor M65.  
Connect FS65SBC to PC using a modified FT232R USB-SERIAL adapter  
for full CTS/RTS handshaking.  
Copy the utilities in your $HOME/bin which must be in your PATH!  
The devlopement was made on DEBIAN 12; you also need the following packages:  
python3, python3-serial, python3-intelhex, cpmtools, xa65, cc65, make...  
In your $HOME/bin symlink /usr/share/python3-intelhex/bin2hex.py to bin2hex  
(ln -s /usr/share/python3-intelhex/bin2hex.py bin2hex).  
If you have an TL866 II Plus universal programmer install  
https://gitlab.com/DavidGriffith/minipro/   
For EPROM-EMU-NG eprom emulator install  
https://github.com/Kris-Sekula/EPROM-EMU-NG
<pre>
65baud:   prints the baud rate  
65rtc:    sets RTC on FS65SBC with M65  
65term:   runs PUTTY with the proper baud rate and serial port   
lsserial: lists serial port or finds specific one  
tspeed:   computes the SD/CF/AT24C256 speed   
*.png:    icons  
</pre>
