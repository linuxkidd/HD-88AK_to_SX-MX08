#!/bin/bash

sudo apt-get update
sudo apt-get -y --force-yes upgrade
sudo apt-get -y --force-yes install mosquitto nodered npm nginx

echo "############################################"
echo "############################################"
echo "##                                        ##"
echo "## Getting ready to install a perl module ##"
echo "## If this is the first time you've done  ##"
echo "## this process, you'll be asked to auto  ##"
echo "## configure.  Simply hit enter to allow  ##"
echo "## auto config to do its thing.           ##"
echo "##                                        ##"
echo "############################################"
echo "############################################"

sudo perl -MCPAN -e 'install Net::MQTT::Simple'

sed -i -e 's/mqtt_en=0/mqtt_en=1/' ~pi/hdmi/matrix.conf

mkdir ~pi/.node-red
cp -a node-red/* ~pi/.node-red/
sudo rm -f /etc/nginx/sites-enabled/default
sudo cp -a nginx/node-ui /etc/nginx/sites-enabled/

cd ~/.node-red/

npm install node-red-dashboard
sudo systemctl start nodered

sudo systemctl enable nginx
sudo systemctl start nginx
cd ~/

echo 
echo Installation complete.
echo Please go to http://$(hostname -I):1880/ to configure your 
echo  HDMI input and output names.
echo
echo Once this is complete, you can go to http://$(hostname -I) 
echo  to use the mobile friendly web interface.
