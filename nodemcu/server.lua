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
  for cmd, rvb in pairs(data) do
    if (cmd == 'color') then 
      tmr.stop(0) -- cleanup

      r = rvb[1]
      v = rvb[2]
      b = rvb[3]
      pixelColor = string.char(r,v,b)
      ws2812.writergb(2, pixelColor:rep(ledsLen))
    elseif (cmd == 'rainbow') then
        tmr.stop(0)
        dofile('snake.lua')
    elseif (cmd == 'star') then
        tmr.stop(0)
        dofile('complement.lua')
    elseif (cmd == 'dot') then
        -- fixme: Make nice 4 dot animation
      pixelColor = string.char(11,22,33)
      ws2812.writergb(2, pixelColor:rep(ledsLen))
    end
  end
end
)

print('UDP server listening on 8080 ...')
s:listen(8080)
