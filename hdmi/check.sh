#!/bin/bash

IFILE=~pi/hdmi/input
OFILE=~pi/hdmi/output
HSCRIPT=~pi/hdmi/hdmi.sh

if [ ! -e $IFILE ] || [ ! -e $OFILE ]; then
	exit
fi

mynow=$(date +%s)
myistat=$(stat -c%Y $IFILE)
myostat=$(stat -c%Y $OFILE)

istatdiff=$((mynow-myistat))
ostatdiff=$((mynow-myostat))

if [ $istatdiff -gt 60 ] || [ $ostatdiff -gt 60 ]; then
	exit
else
	$HSCRIPT $(cat $OFILE) $(cat $IFILE)
	rm -f $IFILE $OFILE
fi
