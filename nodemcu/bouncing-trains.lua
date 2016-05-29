-- Two light trains bouncing from one end to another
pin = 2
leds = 144
intensity = 20

white = string.char(intensity, intensity, intensity)
red = string.char(intensity, 0, 0)
green = string.char(0, intensity, 0)
blue = string.char(0, 0, intensity)
off = string.char (0, 0, 0)
purple = string.char(60, 0, 60)
yellow = string.char(60, 60, 0)

--ws2812.writergb(pin, red..green..blue..purple..white..off:rep(leds))
--tmr.delay(10000)
--ws2812.writergb(pin, off:rep(leds))
--tmr.delay(10000)

current = 1
current_dir = 1
current_seq = red..blue..green..purple..yellow
yellow_cur = leds
yellow_dir = -1

tmr.alarm(0, 20, 1, function() 
    current = current + current_dir
    
    -- Test if need to change direction
    if current_dir == 1 and current >= leds-4 then
      current_dir = -1
    elseif current_dir == -1 and current <= 1 then
      current_dir = 1
    end
    
    yellow_cur = leds - current
    
    if yellow_cur > current then
        dist = yellow_cur - current - 5
        ws2812.writergb(pin, off:rep(current-1)..current_seq..off:rep(dist)..yellow..off:rep(leds))
    
    elseif yellow_cur < current then
        dist = current - yellow_cur
        ws2812.writergb(pin, off:rep(yellow_cur-1)..yellow..off:rep(dist)..current_seq..off:rep(leds))
    
    else 
        ws2812.writergb(pin, off:rep(current-1)..current_seq..off:rep(leds))
    
    end
end)
