tmr.unregister(0)
tmr.unregister(1)

ledsLen = 300

blackPixel = string.char(0, 0, 0)
ws2812.writergb(2, blackPixel:rep(ledsLen))
