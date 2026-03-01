; homeall.g
; called to home all axes
;█
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
;; reduce accelerations to avoid false triggering 
M201 X500 Y500				; reduce acceleration to avoid false triggering

M150 E0 R255 U70 P255 S25 ; set LED to orange ignify caution
;== Home Axis Y
M98 P"homey.g"

;== Home Axis X
M98 P"homex.g"



;== Home Axis Z
M98 P"homez.g"

;G91              ; relative positioning
;G90              ; absolute positioning
;G1 X160 Y230 F6000 ; go to first probe point in middle of bed
;M906 Z500 ;motor amperage   - original 850
;M566 Z100 ; Motor Jerk value mm/m original 400
;G30              ; home Z by probing the bed
;
;G32				; Independent Z leveling pass
;M566 Z400 ; Motor Jerk value mm/m original 400
;M906 Z850 ;motor amperage   - original 850
;
;M201 X18000.00 Y18000.00 Z300.00 E4000.00    
; Uncomment the following lines to lift Z after probing
;G91                    ; relative positioning
;G1 Z10 F100            ; lift Z relative to current position
;G90                    ; absolute positioning

M150 E0 R255 U255 B255 P255 S25 ; set LED to orange ignify caution
