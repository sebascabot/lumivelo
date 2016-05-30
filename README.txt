Arduino (UNO)

  Code to read a RFID tag and send the SerialNumber on the serial link in JSON format.


Raspbian (RaspberryPi)

  To provide IP, we use DHCP capability of `dnsmasq`

  To provide a Wifi access point we use `hostapd`

        SSID: rfid
    Password: untourlanuit

  To send UDP message to all ESP, we use a nodejs assplication


NodeMCU (ESP8266)

  In lua we have a UDP server running.
  We interpret the UDP data to choose which color/effect to display.
