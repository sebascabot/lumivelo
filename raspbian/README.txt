USB WiFi dongle
---------------

  1. Configure wireless interface

     > sudo vi /etc/network/interfaces

     Comment out all line refering to wpa_supplicant and any other wlan# interface.

     Add the following lines

        allow-hotplug wlan0
        iface wlan0 inet static
        address 192.168.111.1
        netmask 255.255.255.0
        gateway 192.168.111.254

  2. Plug in your WiFi USB dongle.

  3. WiFi USB dongle check

     Not all WiFi chipset can act as an access point.

     > iw list

     The output show all access point capability, if you have an empty output
     then your dongle can not be use as an access point. Try another one.

dnsmasq
-------

  1. Install

     > sudo apt-get install dnsmasq

  2. Add configuration file

     > sudo cp dnsmasq/wlan0.conf /etc/dnsmasq.d/.

  3. Add at the end conf-dir=/etc/dnsmasq.d

     > sudo vi /etc/dnsmasq.conf

hostapd
-------

  1. Install

     > sudo apt-get install hostapd

  2. Add configuration file

     > sudo cp hostapd/hostapd.conf /etc/hostapd/.

  3. Add DAEMON_CONF="/etc/hostapd/hostapd.conf"

     > sudo vi /etc/default/hostapd

  4. Add a sleep 4 in the start) section before start-stop-deamon command

     > sudo vi /etc/init.d/hostapd

nodejs application
------------------

  1. Install

     > sudo apt-get install npm nodejs-legacy


  2. Fix v8.h problem

     Ref: https://github.com/fivdi/onoff/wiki/Node.js-v0.10.29-and-native-addons-on-the-Raspberry-Pi

     There is a Debian Unstable patch that is disputed for fixing the issue.
     This patch can be manully applied by replacing the following snippet of code
     in /usr/include/nodejs/deps/v8/include/v8.h:

       enum WriteOptions {
         NO_OPTIONS = 0,
         HINT_MANY_WRITES_EXPECTED = 1,
         NO_NULL_TERMINATION = 2,
         PRESERVE_ASCII_NULL = 4,
       };

     with:

       enum WriteOptions {
         NO_OPTIONS = 0,
         HINT_MANY_WRITES_EXPECTED = 1,
         NO_NULL_TERMINATION = 2,
         PRESERVE_ASCII_NULL = 4,
         REPLACE_INVALID_UTF8 = 0
       };

     Then, we can do as usual

  3. Install dependencies

     > cd rfid2esp # Go in nodejs application directory
     > npm install

  4. Plug-in the Arduino

     Look for the serial device (Ex. /dev/ttyACM0 for UNO or /dev/ttyUSB0 for nano)

     > ls /dev/tty???[0-9]

     Configure `arduinoSerial` in `index.js` to match your serial device tty.

     > vi index.js

  5. Run the application

     > node index.js

