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
		if [ $(echo $i | egrep -c '^O[1-8]O(N|FF)$') -eq 1 ]; then
			myOut=$(echo $i | sed -e 's/[^0-9]//g')
			myState=$(echo $i | sed -e 's/^..//')
			updatemqtt ${myOut}_state $myState
		fi
		
	done
}

function changeState {
	message='fail'
	myOut=$(echo $1 | sed -e 's/[^0-9]//g')
	for i in $(wget -O- -q "http://${matrix_ip}/TimSendCmd.CGI?button=O${myOut}${2}" | awk -F= '{print $2}' | tr '\&' '\n'); do
		if [ $(echo $i | grep -c O${myOut}${2}) -eq 1 ]; then
			message='success'
		fi
		if [ $(echo $i | egrep -c ^O[1-8]I[1-8]$) -eq 1 ]; then
			updatemqtt $(echo $i | sed -e 's/[OI]/ /g')
		fi
		if [ $(echo $i | egrep -c '^O[1-8]O(N|FF)$') -eq 1 ]; then
			myOut=$(echo $i | sed -e 's/[^0-9]//g')
			myState=$(echo $i | sed -e 's/^..//')
			updatemqtt ${myOut}_state $myState
		fi
	done

}

function changeInput {

	message='fail'
	for i in $(wget -O- -q "http://${matrix_ip}/TimSendCmd.CGI?button=O${1}I${2}" | awk -F= '{print $2}' | tr '\&' '\n'); do
		if [ $(echo $i | grep -c O${1}I${2}) -eq 1 ]; then
			message='success'
		fi
		if [ $(echo $i | egrep -c ^O[1-8]I[1-8]$) -eq 1 ]; then
			updatemqtt $(echo $i | sed -e 's/[OI]/ /g')
		fi
		if [ $(echo $i | egrep -c '^O[1-8]O(N|FF)$') -eq 1 ]; then
			myOut=$(echo $i | sed -e 's/[^0-9]//g')
			myState=$(echo $i | sed -e 's/^..//')
			updatemqtt ${myOut}_state $myState
		fi
	done
	echo $message
}

if [ -z $2 ]; then
	checkStatus
	exit
fi

if [ $(echo $1 | grep -c _state) -eq 1 ]; then
	changeState $1 $2
else

	if [ $1 -gt 9 -o $2 -gt 8 ]; then
		usage
	fi

	changeInput $1 $2
fi

