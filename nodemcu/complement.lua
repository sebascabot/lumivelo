-- Attempt to write next pixel with complement color of previous pixel.
-- This will alternate between two color
-- The initial pixel color is generator at random
-- We use a pondaration to avoid to hit the white to often

ledsLen = 300

r = math.random(255) / 3
v = math.random(255) / 4 
b = math.random(255) / 5 

r1 = (255 - (r * 3)) / 3
v1 = (255 - (v * 4)) / 4
b1 = (255 - (b * 5)) / 5

pixel01 = string.char(r,v,b)
pixel02 = string.char(r1,v1,b1)

pinLed = 2
ws2812.writergb(pinLed, (pixel01..pixel02):rep(ledsLen / 2)) -- Magic number 2, because 2 pixels
