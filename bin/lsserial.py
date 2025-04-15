#!/usr/bin/env python3
# finds serial port
import sys
import serial.tools.list_ports
import argparse

ports = serial.tools.list_ports.comports()

parser = argparse.ArgumentParser(description='Find serial port')
parser.add_argument('-v', '--verbose', action='store_true', help='verbose')
parser.add_argument('portstring', nargs='?', help='port description string')
args = parser.parse_args()

if args.portstring==None:
    finds=""
else:
    finds=args.portstring

for i in ports:
    #print(i[2])
    founded=i[1].find(finds)
    if founded==-1:
        founded=i[2].find(finds)
    if args.verbose:
        if founded!=-1:
            print(i[0])
            print("    ",i.manufacturer,i[1])
            print("    ",i[2])
    else:
        if finds=='':
            print(i)
        else:
            if founded!=-1:
                print(i[0])

