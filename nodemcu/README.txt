
1. Install NodeMCU firmware with modules:
  bit cjson file gpio net node tmr uart wifi ws2801 ws2812.

  > ./esptool.py --port /dev/ttyUSB0 write_flash -fm qio -fs 4m 0x00000 nodemcu-master-11-modules-2016-06-01-12-14-07-integer.bin

2. Upload the files

    connect.lua : Connect to our RFID WiFi network
     status.lua : Display connect status
     server.lua : Listen for UDP data and display proper light pattern

    rainbow.lua : Custom effect
       star.lua : Custom effect
        doc.lua : Custom effect

       init.lua : call the three above in sequence at ESP/NodeMCU power up.



Info about the others files
------------------------------------

star-led-test.lua   : Test ligth some shape in Pascal star.
star-led-rotate.lua : First code to sync bike rotation speed with led effect using a Reed Switch.
