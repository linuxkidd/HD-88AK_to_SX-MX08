#!/bin/bash

echo -n $1 | tee ~pi/hdmi/input &> /dev/null
~pi/hdmi/check.sh
