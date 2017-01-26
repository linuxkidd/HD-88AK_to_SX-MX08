#!/bin/bash

sudo apt-get update
sudo apt-get -y --force-yes upgrade
sudo apt-get -y --force-yes install lirc

sudo cp ~pi/lirc/* /etc/lirc/
sudo update-rc.d lirc enable
