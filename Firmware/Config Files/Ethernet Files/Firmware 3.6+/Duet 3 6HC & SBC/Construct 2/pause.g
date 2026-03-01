; pause.g
; called when a print from SD card is paused
;█
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
M150 E0 R255 U70 P255 S25 ; set LED to orange ignify caution
M83            ; relative extruder moves
G1 E-6 F2000  ; retract 6mm of filament
if move.axes[2].machinePosition < 100
    G1 Z100
    


G91            ; relative positioning
G1 Z15 F360     ; lift Z by 15mm
G90            ; absolute positioning
G1 X10 Y10 F6000 ; go to X=10 Y=10

