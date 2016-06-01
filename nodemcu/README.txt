
Install NodeMCU firmware with modules:
  bit cjson file gpio net node tmr uart wifi ws2801 ws2812.

Upload the files

    connect.lua : Connect to our RFID WiFi network
     status.lua : Display connect status
     server.lua : Listen for UDP data and display proper light pattern

       init.lua : call the three above in sequence at ESP/NodeMCU power up.



Info about the others files
------------------------------------

star-led-test.lua   : Test ligth some shape in Pascal star.
star-led-rotate.lua : First code to sync bike rotation speed with led effect using a Reed Switch.
