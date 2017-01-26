#!/bin/bash

source ~pi/hdmi/matrix.conf

function usage {
	echo
	echo "	Usage: $0 <out> <in>"
	echo
	echo "		Out / In is any of 1 through 8"
	echo
	exit
}

function updatemqtt {
	if [ $mqtt_en -eq 1 ]; then
		/usr/local/bin/mqtt-simple -h localhost -p "HDMI/${1}" -r -m "${2}" &
	fi
}

function checkStatus {
	for i in $(wget -O- -q "http://${matrix_ip}/VIDDivSta.CGI" | awk -F= '{print $2}' | tr '\&' '\n'); do
		if [ $(echo $i | egrep -c ^O[1-8]I[1-8]$) -eq 1 ]; then
			updatemqtt $(echo $i | sed -e 's/[OI]/ /g')
		fi
	done
}

function changeInput {

	message='fail'
	inSel="I${2}"
	if [ $2 -eq 0 ]; then
		inSel="OFF"
	fi
	for i in $(wget -O- -q "http://${matrix_ip}/TimSendCmd.CGI?button=O${1}${inSel}" | awk -F= '{print $2}' | tr '\&' '\n'); do
		if [ $(echo $i | grep -c O${1}I${2}) -eq 1 ]; then
			message='success'
		fi
		if [ $(echo $i | egrep -c ^O[1-8]I[1-8]$) -eq 1 ]; then
			updatemqtt $(echo $i | sed -e 's/[OI]/ /g')
		fi
	done
	echo $message
}

if [ -z $2 ]; then
	checkStatus
	exit
fi

if [ $1 -gt 9 -o $2 -gt 8 ]; then
	usage
fi

changeInput $1 $2

