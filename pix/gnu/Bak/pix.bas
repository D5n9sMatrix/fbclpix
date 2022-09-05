#define SIZE 160
#define PIX 4
#define NXT (1-CURR)
#define WHITE rgb(255,255,255)
#define FRAMERATE 1./25

declare sub draw_world( world() as uinteger, CURR as uinteger)
declare sub iterate_world( world() as uinteger, CURR as uinteger)
declare function mm( i as integer ) as uinteger

screenres SIZE*PIX, SIZE*PIX, 32
dim as uinteger world( 0 to SIZE-1, 0 to SIZE-1, 0 to 1 ), CURR = 0
dim as double timed

'randomize world
for x as uinteger = 0 to SIZE - 1
    for y as uinteger = 0 to SIZE - 1
        world(x, y, CURR) = int(rnd*2)
    next y
next x

while inkey()=""
    timed = timer
    draw_world( world(), CURR )
    iterate_world( world(), CURR )
    CURR = NXT
    while timer < timed + FRAMERATE
    wend
    line (0,0)-(PIX*SIZE, PIX*SIZE), 0, BF
wend

sub draw_world( world() as uinteger, CURR as uinteger)
    for x as integer = 0 to SIZE-1
        for y as integer = 0 to SIZE-1
            if world(x, y, CURR) = 1 then line (PIX*x, PIX*y)-(PIX*(x+1), PIX*(y+1)), WHITE, BF
        next y
    next x
end sub

sub iterate_world( world() as uinteger, CURR as uinteger)
    dim as integer sum
    for x as integer = 0 to SIZE-1
        for y as integer = 0 to SIZE-1
            sum = world( mm(x-1), mm(y-1), CURR ) + world( mm(x), mm(y-1), CURR ) _
                + world( mm(x+1), mm(y-1), CURR ) + world( mm(x-1), mm(y), CURR ) _
                + world( mm(x+1), mm(y), CURR ) + world( mm(x-1), mm(y+1), CURR ) _
                + world( mm(x), mm(y+1), CURR ) + world( mm(x+1), mm(y+1), CURR )
            world( x, y, NXT ) = 0
            if sum = 3 then world( x, y, NXT ) = 1
            if sum = 2 and world( x, y, CURR ) = 1 then world( x, y, NXT ) = 1
        next y
    next x
end sub

function mm( i as integer ) as uinteger
    if i=-1 then return SIZE-1
    if i=SIZE then return 0
    return i
end function

