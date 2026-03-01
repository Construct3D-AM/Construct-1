;T-1                 ;deselect tool
G29 S2              ;clear and disable mesh compensation
G1 X330 Y230 F6000 ;move to centre of the bed X0 Y0 At about 15omm/s

;Lower motor amperage to protect nozzle
M906 Z380 ;motor amperage   - original 850
M201 Z300 ; Motor accel

;Fast probe upwards with scanning mode
M558.3 K1 S0
G30 k1
;Switch to touch mode
M558.3 K1 S1
G30 k1

;Reset motor amperage
M906 Z850 ;motor amperage   - original 850


G1 Z6             ; to avoid backlash
M558.1 K1 S1.5
G29 S0 K1
;G1  Y3 F18000