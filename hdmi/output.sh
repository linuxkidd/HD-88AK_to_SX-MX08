#!/bin/bash

echo -n $1 | tee ~pi/hdmi/output &> /dev/null
~pi/hdmi/check.sh
