; homey.g
; called to home the Y axis
;
; generated by RepRapFirmware Configuration Tool v3.3.3 on Wed Sep 29 2021 19:26:52 GMT+0100 (British Summer Time)
M201 X500 Y500				; reduce acceleration to avoid false triggering

G91               ; relative positioning


M913 X30 Y30      ; drop motor current to 30%
G1 H1 Y385 F4000 ; move quickly to Y axis endstop at minimum of 30mm/s for stall detection 
G1 Y-10 F6000       ; go back a few mm
M913 X100 Y100    ;raise motor current to 100%

	
G90               ; absolute positioning
M201 X20000.00 Y20000.00 Z300.00 E4000.00    
