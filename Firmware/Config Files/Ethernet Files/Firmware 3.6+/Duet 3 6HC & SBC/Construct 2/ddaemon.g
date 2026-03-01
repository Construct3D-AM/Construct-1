; global variable colour
; if colour do X
while true
    if mod(state.upTime, 2) == 0
        M150 E0 R255 P255 S25  ;set LED red
        ;else do y
    if mod(state.upTime, 2) == 1
        M150 E0 B255 P255 s25  ;Set LED blue
    G4 S0.1



