r=180
v=0
b=15
etoile_grande = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b)
etoile_petite = string.char(0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0)
tout = string.char(r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b)
eteint = string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0)

local pin = 5    --> GPIO14

function debounce (func)
    local last = 0
    local delay = 200000

    return function (...)
        local now = tmr.now()
        if now - last < delay then return end

        last = now
        return func(...)
    end
end

function tourni()
    minangle_1 = string.char(r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b)
    ws2812.writergb(2,minangle_1)
    tmr.delay(100000)
    minangle_2 = string.char(0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0)
    ws2812.writergb(2,minangle_2)
    tmr.delay(100000)
    minangle_3 = string.char(0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0)
    ws2812.writergb(2,minangle_3)
    tmr.delay(100000)
    minangle_4 = string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0)
    ws2812.writergb(2,minangle_4)
    tmr.delay(100000)
    minangle_5 = string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0)
    ws2812.writergb(2,minangle_5)
    tmr.delay(100000)
    ws2812.writergb(2,eteint)
end

function battement()
    pentagone_grand = string.char(r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b)
    ws2812.writergb(2,pentagone_grand)
    tmr.delay(50000)
    pentagone_moyen = string.char(0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0)
    ws2812.writergb(2,pentagone_moyen)
    tmr.delay(500000)
    pentagone_petit = string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0)
    ws2812.writergb(2,pentagone_petit)
    tmr.delay(500000)
    pentagone_moyen = string.char(0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0)
    ws2812.writergb(2,pentagone_moyen)
    tmr.delay(500000)
    pentagone_grand = string.char(r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, r,v,b, r,v,b, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, r,v,b, r,v,b, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b, 0,0,0, 0,0,0, r,v,b)
    ws2812.writergb(2,pentagone_grand)
    ws2812.writergb(2,eteint)
end

gpio.mode(pin, gpio.INT)
gpio.trig(pin, 'both', debounce(tourni))
