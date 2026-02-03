
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
;General Setup
M575 P1 S1 B57600                                      ; enable support for PanelDue
G90                                                    ; send absolute coordinates...
M83                                                    ; ...but relative extruder moves
M550 P"Construct 1 XL V13"                                            ; set printer name
M669 K1                                                ; select CoreXY mode


; Enable network
if {network.interfaces[0].type = "ethernet"}
    M552 S1
else
    M552 S1

;███████████████████████████████████████████████████████████████████████████████████
;Drive setup
M569 P0.0 S1                                           ; extruder motor physical drive goes forwards
M569 P0.1 S0 D2                                        ; XYr motor physical drive goes forwards
M569 P0.2 S0 D2                                        ; XYl motor physical drive goes forwards
M569 P0.3 S1 D2                                          ; Zr motor physical drive goes forwards
M569 P0.4 S1 D2                                          ; Zl motor physical drive goes forwards


M584 X0.1 Y0.2 Z0.3:0.4 E0.0                           ; set drive mapping
M350 X16 Y16 Z16 I1                                    ; configure microstepping with interpolation
M350 E16 I1
M92 X80 Y80 Z800 E397                                  ;Set steps per/mm

;███████████████████████████████████████████████████████████████████████████████████
;Drive Control
M566 X2000 Y2000 Z40 E500.00                          ; set maximum instantaneous speed changes (mm/min)
M203 X30000 Y30000 Z1500 E30000.00                     ; set maximum speeds (mm/min)  - 500mm/s XY
M201 X10000 Y10000 Z300 E5000                          ; set accelerations (mm/s^2)
M906 X1700 Y1700 Z850 E1200 I50                        ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                                ; Set idle timeout

; Stall detection Values
M915 P0.1:0.2 S8 F0 H100 

;███████████████████████████████████████████████████████████████████████████████████
;Printer Control
; Axis Limits
M208 X0 Y0 Z0 S1                                       ; set axis minima
M208 X328 Y360 Z400 S0                                 ; set axis maxima

; Endstops
M574 X1 S3                                             ; configure sensorless endstop for low end on X
M574 Y2 S3                                             ; configure sensorless endstop for high end on Y
;M574 Z1 S1 P"121.io0.in"                                            ; configure z-probe endstop active high

; P+F Z-Probe
;M558 K0 P8 C"!io6.in" H3:2 F600:100 A3 T12000         ; disable Z probe but set dive height, probe speed and travel speed
;M557 X15:300 Y30:330 P7                                ; define mesh grid
;G31 K0 P800 X0 Y-21 Z1.88                                 ; set Z probe trigger value, offset and trigger height

;Peizo Probe
M558 K0 P8 C"!io1.in" R1 F1200 A15 H8 S0.04
M557 X5:310 Y10:360 P11
G31 X0 Y0 Z-0.02 K0

;Independent Z leveling
M671 X-10:340 Y190:190 S10                             ; leadscrews locations at left (connected to Z) and right (connected to E1) of X axis

;███████████████████████████████████████████████████████████████████████████████████
;Heater Control

;nozzle heater
M308 S1 P"0.temp2" Y"thermistor" A"Nozzle"             ; configure sensor 1 as thermistor on pin temp1
M950 H1 C"0.out1" T1                                   ; create heater and map sensor 1 (toolboard)
M307 H1 R1.974 K0.387:0.000 D5.45 E1.35 S1.00 B0 V24.9 ; Disable Bang Bang
M143 H1 S340                                           ;set max temp
;bed heater
M308 S0 P"0.temp0" Y"thermistor" A"Bed" T100000 B3950  ; configure sensor 0 as thermistor on pin temp1
M950 H0 C"0.out0" T0                                   ; create bed heater output on out1 and map it to sensor 0
M307 H0 R0.591 K0.268:0.000 D3.07 E1.35 S1.00 B0       ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                ; map heated bed to heater 0
M143 H0 S130                                           ;set max temp

;███████████████████████████████████████████████████████████████████████████████████
;Fan Control

M950 F0 C"out5" Q500                                   ; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1                                         ; set fan 0 value. Thermostatic control is turned off
M950 F1 C"out6" Q500                                   ; create fan 1 on pin fan1 and set its frequency
M106 P1 S0 H-1                                         ; set fan 1 value. Thermostatic control is turned off

;███████████████████████████████████████████████████████████████████████████████████
;Tools
M563 P0 S"Nozzle" D0 H1 F0:1                           ;Create tool0 called heater using the first extruder (0) in the list using heater 1 and fan 1
G10 P0 X0 Y0 Z0 R0 S0                                  ;set active and standby to 0
T0

;███████████████████████████████████████████████████████████████████████████████████
;Quality enchancements
M593 P"EI2" F45 S0.01                                  ; input shaping
M572 D0 S0.012                                         ; pressure advance
M309 S0.022 P0                                         ; material feedforward


