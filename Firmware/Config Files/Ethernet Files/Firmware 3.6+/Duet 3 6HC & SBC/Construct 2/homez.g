; homez.g
; called to home the Z axis
;█
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
G4 S0.5
if sensors.probes[1].value[0] >= 7000
	G92 Z8
	G1 Z15 F400

if sensors.analog[1].lastReading < 100
	M291 P"Nozzle Temperature below 100C, unsafe bed homing detected, aborting" R"Nozzle Temp Min Fail" S1
else 
	;== Centre nozzle in bed
	G1 X335 Y230 F6000 ; go to first probe point in middle of bed
	M201 X500 Y500 Z300			; reduce acceleration to avoid false triggering
	M906 Z380 ;motor amperage   - original 850
	M566 Z100 ; Motor Jerk value mm/m original 400

	G91              ; relative positioning
	G90              ; absolute positioning

	;Fast probe upwards with scanning mode
	M558.3 K1 S0
	G30 k1
	;Switch to touch mode
	M558.3 K1 S1
	G30 k1	
	;reset to scan mode
	M558.3 K1 S0
	; Move bed down ready for z rods
	G1 Z10

	G32				 ; Independent Z leveling pass (calling bed.g)

	;Reset motor and acceleration values
	M906 Z850 ;motor amperage
	M566 Z200 ; Motor Jerk value mm/m original 400
M201 X10000.00 Y10000.00 Z300.00 E4000.00    


; Uncomment the following lines to lift Z after probing
;G91             ; relative positioning
;G1 Z10 F100     ; lift Z relative to current position
;G90             ; absolute positioning

