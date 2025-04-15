#!/usr/bin/env python3
# tspeed - fs65sbc utility - compute speed for SD/CF/AT24C256
# paste begin and end from putty
# usage: tspeed -b hhhhhh -e hhhhhh
# by Fabio Sturman (c) 2025
# fabio.sturman@gmail.com
# GNU GENERAL PUBLIC LICENSE Version 3
import argparse
parser = argparse.ArgumentParser(description='Compute speed for SD/CF/AT24C256 (default= KiB/s)')
parser.add_argument('-b', '--beg', default='080', help='begin time in ticks hex')
parser.add_argument('-e', '--end', default='100', help='end time in ticks hex')
parser.add_argument('-r', '--read', type=int, default=480, help='bytes readed in KiB (default=480)')
parser.add_argument('-t', '--tick', type=float, default=0.02, help='tick duration in s (default=0.02)')
parser.add_argument('-k', '--kilo', action='store_true', help='speed in kB/s (default=KiB/s)')
parser.add_argument('-v', '--verbose', action='store_true')
args = parser.parse_args()

nbeg=int(args.beg,16)
nend=int(args.end,16)
delta=(nend-nbeg)*args.tick
speed=args.read/delta

if nbeg >= nend:
    print('Error: begin>=end!')
    exit(1)
if args.tick <= 0.0:
    print('Error: tick<=0!')
    exit(2)
if args.read < 0.0:
    print('Error: read<0!')
    exit(3)

if args.verbose:
    print('Begin= ',nbeg*args.tick,'s')
    print('End=   ',nend*args.tick,'s')
    print('Data=  ',args.read,'KiB')
    print('Tick=  ',args.tick,'s')
    print('----------------------------------')
    print('Speed= %.2f KiB/s'%speed)
    print('Speed= %.2f kB/s'%(speed*1.024))
else:
    if args.kilo:
        print('%.2f'%(speed*1.024))
    else:
        print('%.2f'%(speed))
exit(0)
