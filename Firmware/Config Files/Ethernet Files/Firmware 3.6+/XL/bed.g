; bed.g
; called to perform automatic bed compensation via G32
;
; generated by RepRapFirmware Configuration Tool v3.3.3 on Wed Sep 29 2021 19:26:52 GMT+0100 (British Summer Time)
M561 ; clear any bed transform

	G30 P1 X15 Y210 Z-9999 ; probe near a leadscrew left
	G30 P0 X330 Y210 Z-9999 S2; probe near a leadscrew right
	
		G30 P1 X15 Y210 Z-9999 ; probe near a leadscrew left
		G30 P0 X330 Y210 Z-9999 S2; probe near a leadscrew right

	M201 X20000.00 Y20000.00    ;set accelerations (mm/s^2)
	G29						;;Mesh compensation 

