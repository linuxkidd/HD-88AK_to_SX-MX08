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
cp -a ~pi/node-red/* ~pi/.node-red/

cd ~/.node-red/

npm install node-red-dashboard
sudo systemctl start nodered

sudo rm -f /etc/nginx/sites-enabled/default
sudo cp -a ~pi/nginx/node-ui /etc/nginx/sites-enabled/
sudo systemctl enable nginx
sudo systemctl start nginx

