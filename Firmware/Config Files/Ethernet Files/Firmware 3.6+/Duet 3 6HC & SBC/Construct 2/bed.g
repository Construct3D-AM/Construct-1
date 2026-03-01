; bed.g
; called to perform automatic bed compensation via G32
;█
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
M561 ; clear any bed transform

M906 Z380 ;motor amperage   - original 850
	G1 F9000
	G30 K1 P1 X20 Y210 Z-9999 ; probe near a leadscrew left
	G30 K1 P0 X348 Y210 Z-9999 S2; probe near a leadscrew right
	
		G30 K1 P1 X20 Y210 Z-9999 ; probe near a leadscrew left
		G30 K1 P0 X348 Y210 Z-9999 S2; probe near a leadscrew right

		G1 Z10

		M906 Z850 ;motor amperage   - original 850

	;M201 X10000.00 Y10000.00    ;set accelerations (mm/s^2)
	G29						;;Mesh compensation 

