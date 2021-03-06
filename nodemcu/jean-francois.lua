i = 50 -- Intensity (Max)

white  = string.char(i, i, i)
red    = string.char(i, 0, 0)
green  = string.char(0, i, 0)
blue   = string.char(0, 0, i)
black  = string.char(0, 0, 0)
purple = string.char(i, 0, i)
yellow = string.char(i, i, 0)

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
    if (inc < 0) then
      tmr.start(0)
    else
      tmr.stop(0)
      r = math.random(50)
      v = math.random(50)
      b = math.random(50)
      pixel = string.char(r, v, b)
      ws2812.writergb(pin, pixel:rep(ledsLen))
     end
end)

magPin = 5 -- Magnet

gpio.mode(magPin, gpio.INT)
gpio.trig(magPin, 'up', function (level)
  tmr.start(idMagnet)
end)

-- Two light trains bouncing from one end to another

pin = 2
ledsLen = 300


speed = 6 -- Speed divider
tick = 1


len = 3
run = yellow:rep(len)..red:rep(len)..green:rep(len)..purple:rep(len)
run = run:rep(3)
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
    pos = pos + inc

    if (pos > (ledsLen - runLen)) then
      inc = -1
      pos = ledsLen - runLen
    elseif (pos < 1) then
      inc = 1
      pos = 1
    end

    leftLen = pos
    rightLen = ledsLen - (leftLen + runLen)
    ws2812.writergb(pin, black:rep(leftLen)..run..black:rep(rightLen))
  end

  tmr.start(id)

end)

tmr.start(id)
