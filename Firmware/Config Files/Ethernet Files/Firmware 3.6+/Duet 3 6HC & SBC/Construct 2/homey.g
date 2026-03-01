; homey.g
; called to home the Y axis
;█
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
M201 X500 Y500				; reduce acceleration to avoid false triggering

G91               ; relative positioning

G4 S0.5
if sensors.probes[1].value[0] >= 7000
	G92 Z8
	G1 Z15 F400

M913 X30 Y30      ; drop motor current to 30%
G1 H1 Y495 F10000 ; move quickly to Y axis endstop for stall detection 
G1 Y-95 F6000       ; go back a few mm
M913 X100 Y100    ;raise motor current to 100%

	
G90               ; absolute positioning
M201 X18000.00 Y18000.00 Z300.00 E4000.00    

