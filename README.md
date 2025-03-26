# fs65sbc
Simple single board computer with 6502/65C02

Technical data:  
1x MICROPROCESSOR 65C02  
1x IDE 8 bit interface for CF card  
2x SPI interface for SD card  
1x SERIAL PORT @38400 baud (38400-8-N-1) interrupt driven with handshake CTS/RTS  
1x SOFTWARE only tx serial port  
1x I2C port  
1x RTC with backup battery  
1x I2C eeprom AT24C256  
1x RESET button  
1x EXTERNAL reset pin  
1x DEBUG output pin  
1x SMALL interface connector  
1x BUZZER  
1x RESET supervisor  
1x VIA 65C02  
1x ACIA 65C51  
1x GAL address decoder  
128 KiB static ram with 8 KiB paged memory  
8 KiB (e)eprom  
7 KiB monitor m65  

Connect the FS65SBC to a PC using FT232RL modified USB-SERIAL adapters  
<img src="./img/ftdi232-t.jpg" alt="Adapter top" width=500/>  
<img src="./img/ftdi232-b.jpg" alt="Adapter bottom" width=500/>  
<img src="./img/fs65sbc-1.png" alt="FS65SBC BOARD" width=800/>  
<img src="./img/fs65sbc-screen2.png" alt="SCREENSHOT2"/>  
<img src="./img/fs65sbc-screen.png" alt="SCREENSHOT" width=1000/>
