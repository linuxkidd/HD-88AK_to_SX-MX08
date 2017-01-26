#!/bin/bash

sudo apt-get update
sudo apt-get -y --force-yes upgrade
sudo apt-get -y --force-yes install lirc

cp -a hdmi ~pi/

sudo cp lirc/* /etc/lirc/
sudo update-rc.d lirc enable
sudo service lirc start

echo "## Installation complete!"
echo "## Please edit the ~/pi/hdmi/matrix.conf file to set your HDMI Matrix IP address."

