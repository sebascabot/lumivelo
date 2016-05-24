while 1 do
r=15
v=0
b=180
tout = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b)
ws2812.writergb(2, tout)
tmr.delay(500000)
r=150
v=0
b=0
etoile_grande = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b)
ws2812.writergb(2,etoile_grande)
tmr.delay(500000)
r=0
v=150
b=0
etoile_petite = string.char(0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0)
ws2812.writergb(2,etoile_petite)
tmr.delay(500000)
r=0
v=0
b=150
triangle_1 = string.char(r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b)
ws2812.writergb(2,triangle_1)
tmr.delay(500000)
r=150
v=150
b=150
triangle_2 = string.char(0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0)
ws2812.writergb(2,triangle_2)
tmr.delay(500000)
r=50
v=150
b=50
triangle_3 = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b)
ws2812.writergb(2,triangle_3)
tmr.delay(500000)
r=150
v=0
b=0
triangle_4 = string.char(r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, r,v,b)
ws2812.writergb(2,triangle_4)
tmr.delay(500000)
r=0
v=150
b=0
triangle_5 = string.char(0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0)
ws2812.writergb(2,triangle_5)
tmr.delay(500000)
r=0
v=0
b=150
pentagone_grand = string.char(r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b)
ws2812.writergb(2,pentagone_grand)
tmr.delay(500000)
r=150
v=150
b=150
pentagone_moyen = string.char(0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0)
ws2812.writergb(2,pentagone_moyen)
tmr.delay(500000)
r=150
v=150
b=0
pentagone_petit = string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0)
ws2812.writergb(2,pentagone_petit)
tmr.delay(500000)
r=0
v=150
b=150
tout = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b)
ws2812.writergb(2,tout)
end
