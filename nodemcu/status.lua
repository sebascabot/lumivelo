print("MAC: "..wifi.sta.getmac())

v = wifi.sta.status()
if     v == 0 then print("STA_IDLE")
elseif v == 1 then print("STA_CONNECTING")
elseif v == 2 then print("STA_WRONGPWD")
elseif v == 3 then print("STA_APNOTFOUND")
elseif v == 4 then print("STA_FAIL")
elseif v == 5 then
  print("STA_GOTIP")
  print(wifi.sta.getip())
else
  print("ERROR! Invalid status number: ", v)
end

