# Accept IR commands for A-NeuVideo HD-88AK and send control signals to the FoxUn SX-MX08

## WARNING ##
I do not personally recommend the [FoxUn SX-MX08](http://foxun.com/product_detail_836.html).  The unit I received has a board inside which uses assembly number MUH88A-A and leads back to [PTN Electronics](http://ptnelectronics.com/product/showproduct.php?lang=en&id=34).  Communication with PTN Electronics was met with a response that this device is using an unauthorized copy of their board.  I completed this project because I already had the device, and needed discrete input selection capability for use with a [Logitech Harmony Elite](http://amzn.to/2k5I8Wp).  It was the least expensive 8x8 matrix with 60hz 4K support at the time of my research.  If you have an option to select a different device, you should likely do so.

## Description ##
This repo contains necessary files and scripts to configure a [Raspberry Pi](http://amzn.to/2kvagTB) to accept IR commands for an A-NeuVideo HD-88AK 8x8 HDMI matrix, and send the resulting commands over network to a FoxUn SX-MX08.  The code will work with other FoxUn and similar supplier HDMI matrix switches.  The HD-88AK was selected as the IR profile to emulate as it is present in the Logitech Harmony database and is easily used to control 8x8 HDMI matrix switches.

## Key Features ##
- Accept HD-88AK IR commands
- Transmits discrete input selection commands to the FoxUn SX-MX08 HDMI Matrix switch.
- Permits discrete input selection for advanced universal remotes, like the Logitech Harmony line.
- Includes script and configuration for *optional* Node-Red Dashboard interface to control the SX-MX08 HDMI Matrix switch.

## Links ##
- [Raspberry Pi](http://amzn.to/2kvagTB)
- [IR Receiver Tutorial](https://learn.adafruit.com/using-an-ir-remote-with-a-raspberry-pi-media-center/overview)
- [USB IR Receiver if you don't want to build one](http://amzn.to/2jgSM8y)
- [Another USB IR Receiver](http://amzn.to/2k5SANH) - Ignore the included remote, you just need the receiver
- [FoxUn SX-MX08](http://foxun.com/product_detail_836.html)
- [Logitech Harmony Elite](http://amzn.to/2k5I8Wp) - The remote I use, but any Harmony (and likely other brand) universal remote should work.


## Instructions ##
- Flash a Raspbian ( or Raspbian Lite ) image onto a suitable microSD card for your Raspberry Pi [instructions](https://www.raspberrypi.org/documentation/installation/installing-images/).
- Once logged into your fresh Raspbian install as the 'pi' user, download and extract the repository
```
$ wget https://github.com/linuxkidd/HD-88AK_to_SX-MX08/archive/master.zip
$ unzip master.zip
```
- Run the install_lirc.sh script:
```
$ cd HD-88AK_to_SX-MX08
$ sh install_lirc.sh
```
- Edit the ~pi/hdmi/matrix.conf file to set the IP address of your SX-MX08 HDMI matrix.
- *OPTIONAL* If you want to use the Node-Red Dashboard mobile friendly web interface, run the other install script:
```
$ sh install_nodered.sh
```
- Program your Logitech Harmony (or other remote) to send commands for the A-NeuVideo HD-88AK HDMI Matrix
- If you installed the Node-Red Dashboard interface, put the IP address of your Raspberry Pi into your web browser
  - Example: http://192.168.1.9
- To configure the input and output names, go to port 1880 of your Raspberry Pi in your browser
  - Example: http://192.168.1.9:1880
  - NOTE: Click the comment nodes and follow the instructions on the right in the 'Info' tab to configure your device.

## Screenshots ##
![Node-Red Dashboard Interface](https://raw.githubusercontent.com/linuxkidd/HD-88AK_to_SX-MX08/master/images/Node-Red-Interface.png)
![Node-Red Flows](https://raw.githubusercontent.com/linuxkidd/HD-88AK_to_SX-MX08/master/images/Node-Red-Flows.png)

