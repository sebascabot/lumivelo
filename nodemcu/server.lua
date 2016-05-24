if (s) then
  print('Clean up previous server ...')
  s:close()
  s = nil
end

print('Creating UPD server ...')
s = net.createServer(net.UDP)

s:on("receive", function(s, json) 
  print('receiving...')
  print(json)

  data = cjson.decode(json)
  for cmd, rvb in pairs(data) do
    if (cmd == 'color') then 
      r = rvb[1]
      v = rvb[2]
      b = rvb[3]
      grandeEtoile = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0, 0, 0, 0, 0, 0)
      ws2812.writergb(2, grandeEtoile)
    end
  end
end
)

print('UDP server listening on 8080 ...')
s:listen(8080)
