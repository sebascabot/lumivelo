
-- The 'snake' is a color band which bounce
-- when it reach the other end of the string
--
-- The magnet can be use to force a direction change

ledsLen = 300

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
i = 88 -- Intensity (Max)


speed = 3 -- Speed divider
tick = 1

white  = string.char(i, i, i)
red    = string.char(i, 0, 0)
green  = string.char(0, i, 0)
blue   = string.char(0, 0, i)
black  = string.char(0, 0, 0)
purple = string.char(i, 0, i)
yellow = string.char(i, i, 0)

len = 4
run = yellow:rep(len)..red:rep(len)..green:rep(len)..purple:rep(len)
run = run:rep(4)
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
