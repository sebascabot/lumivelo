
-- The 'snake' is a color band which bounce
-- when it reach the other end of the string
--
-- The magnet can be use to force a direction change

id = 0 -- Timer Id for movement (shift)
idMagnet = 1 -- Timer Id

inc = 1

debounceMs = 600 -- debounce time in millisecond
tmr.alarm(idMagnet, debounceMs, tmr.ALARM_SEMI, function ()
  inc = -inc;
end)

magPin = 5 -- Magnet

gpio.mode(magPin, gpio.INT)
gpio.trig(magPin, 'up', function (level)
  tmr.start(idMagnet)
end)

-- Two light trains bouncing from one end to another

pin = 2
ledsLen = 144
i = 66 -- Intensity (Max)


speed = 25 -- Speed divider
tick = 1

black  = string.char(0, 0, 0)

white  = string.char(i, i, i)
red    = string.char(i, 0, 0)
green  = string.char(0, i, 0)
blue   = string.char(0, 0, i)
purple = string.char(i, 0, i)
yellow = string.char(i, i, 0)

idx2pixel = {}
idx2pixel[1] = white 
idx2pixel[2] = red   
idx2pixel[3] = green 
idx2pixel[4] = blue  
idx2pixel[5] = purple
idx2pixel[6] = yellow

len = 5
run = yellow:rep(len)..red:rep(len)..green:rep(len)..purple:rep(len)
run = run:rep(5)
runLen = run:len() / 3 -- Magic number 3, because each LED have 3 data point. i.e. (R, G, B)

ws2812.writergb(pin, black:rep(ledsLen))

pos = 1

print(tmr.ALARM_SINGLE)
print(tmr.ALARM_SEMI)
print(tmr.ALARM_AUTO)

tmr.stop(id)
tmr.unregister(id)

tmr.alarm(id, 2, tmr.ALARM_SEMI, function ()
  tick = tick + 1

  if (tick % speed == 0) then
  
    run = black

    while(run:len() < (ledsLen * 3)) do
      idx = math.random(6)
      rep = math.random(10)
      run = run..(idx2pixel[idx]:rep(rep))
      rep = math.random(10)
      run = run..(black:rep(rep))
    end

    ws2812.writergb(pin, run)
  end

  tmr.start(id)

end)

tmr.start(id)
