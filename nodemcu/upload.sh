SHAPE="coeur"
SHAPE="."
nodemcu-tool -b 9600 upload init.lua connect.lua status.lua server.lua $SHAPE/star.lua $SHAPE/rainbow.lua $SHAPE/dot.lua
#nodemcu-tool -b 115200 upload init.lua connect.lua status.lua server.lua $SHAPE/star.lua $SHAPE/rainbow.lua $SHAPE/dot.lua
