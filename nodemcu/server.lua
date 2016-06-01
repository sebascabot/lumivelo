-- Setup
ledsLen = 300

-- Cleanup
if (s) then
  print('Clean up previous server ...')
  s:close()
  s = nil
end
tmr.unregister(0)
tmr.unregister(1)
blackPixel = string.char(0, 0, 0)
ws2812.writergb(2, blackPixel:rep(ledsLen))

print('Creating UPD server ...')
s = net.createServer(net.UDP)

s:on("receive", function(s, json) 
  print('receiving...')
  print(json)

  data = cjson.decode(json)
  for cmd, arg in pairs(data) do
    if (cmd == 'rgb') then 
      tmr.stop(0) -- cleanup

      r = arg[1]
      v = arg[2]
      b = arg[3]
      pixelColor = string.char(r,v,b)
      ws2812.writergb(2, pixelColor:rep(ledsLen))
    elseif (cmd == 'cmd') then
        tmr.stop(0)
        dofile(arg..'.lua')
    end
  end
end
)

print('UDP server listening on 8080 ...')
s:listen(8080)
