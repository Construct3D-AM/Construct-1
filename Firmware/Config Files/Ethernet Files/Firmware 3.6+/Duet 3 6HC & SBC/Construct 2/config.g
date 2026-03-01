;█
;   _____ ____  _   _  _____ _______ _____  _    _  _____ _______     ____  _____  
;  / ____/ __ \| \ | |/ ____|__   __|  __ \| |  | |/ ____|__   __|   |___ \|  __ \ 
; | |   | |  | |  \| | (___    | |  | |__) | |  | | |       | |        __) | |  | |
; | |   | |  | | . ` |\___ \   | |  |  _  /| |  | | |       | |       |__ <| |  | |
; | |___| |__| | |\  |____) |  | |  | | \ \| |__| | |____   | |       ___) | |__| |
;  \_____\____/|_| \_|_____/   |_|  |_|  \_\\____/ \_____|  |_|      |____/|_____/ 
;                                                                                

;███████████████████████████████████████████████████████████████████████████████████
;General Setup
M575 P1 S1 B57600                                                     ; enable support for PanelDue
G90                                                                   ; send absolute coordinates...
M83                                                                   ; ...but relative extruder moves
M550 P"C1E"                                                           ; set printer name
M669 K1                                                               ; select CoreXY mode

;███████████████████████████████████████████████████████████████████████████████████
;Tertiary
M950 E0 C"led" T1 U20 Q3200000   ;set strips and Q=Signal frequency
M150 E0 R40 U40 B255 P255 S20 ;Auto set to llight blue on startup

; Wait a moment for the CAN expansion boards to start
G4 S5

;███████████████████████████████████████████████████████████████████████████████████
;Drive setup
; D3    D4    D5
; XYl   N/A   XYr
;
; D2    D1    D0
; Zl    N/A   Zr

M569 P0.3 S0                                                          ; XYl motor physical drive goes forwards
M569 P0.5 S0                                                          ; XYr motor physical drive goes forwards
M569 P0.2 S1                                                          ; zl motor physical drive goes forwards
M569 P0.0 S1                                                          ; zr motor physical drive goes forwards
M569 P121.0 S0                                                        ; ToolBoard Extruder motor physical drive goes backwards

M584 X0.3 Y0.5 Z0.2:0.0 E121.0                                        ; set drive mapping
M350 X32 Y32 Z16 I1                                                   ; configure microstepping with interpolation
M350 E16 I1
M92 X160 Y160 Z800 E410                                              ;Set steps per/mm

;███████████████████████████████████████████████████████████████████████████████████
;Drive Control
M566 X1200 Y1200 Z400 E300                                         ; set maximum instantaneous speed changes (mm/min)
M203 X50000 Y50000 Z1800 E3000.00                                    ; set maximum speeds (mm/min)  - 500mm/s XY
M201 X20000 Y20000 Z500 E10000                                         ; set accelerations (mm/s^2)
M201.1 X600 Y600 Z300
M906 X3950 Y3950 Z850 E1200 I80                                        ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                                               ; Set idle timeout

; Stall detection Values
M915 X Y S3 F0 H100 

;███████████████████████████████████████████████████████████████████████████████████
;Printer Control
; Axis Limits
M208 X0 Y0 Z0 S1                                                      ; set axis minima
M208 X340 Y390 Z400 S0                                                ; set axis maxima

; Endstops
M574 X1 S3                                                            ; configure sensorless endstop for low end on X
M574 Y2 S3                                                            ; configure sensorless endstop for high end on Y

;Duet Scanning Zprobe (Eddy current)
M558 K1 P11 C"121.i2c.ldc1612" F450:200:14000 T14000 A3 H5:H1
M308 A"SZP coil" S10 Y"thermistor" P"121.temp2"                       ; thermistor on coil
G31 K1 P6400 Z2 X17 Y11.5
M558.2 K1 S13 R138974                                                 ;measured at 2.5mm from nozzle against bed Z0
M558.3 K1 S0 H-0.25 V1.8 F450                                                ;Set touch mode operations but disable(S0) touch for now
M557 X20:330 Y30:360 S11


;Toolboard Accelerometer
M955 P121.0 I01                                                       ; Add accelerometer on Roto with CAN address 121 and specify orientation

;Independent Z leveling
M671 X-10:340 Y190:190 S10                                            ; leadscrews locations at left (connected to Z) and right (connected to E1) of X axis

;███████████████████████████████████████████████████████████████████████████████████
;Heater Control
;each gets
;M308 A thermistor maped to a sensor
;M950 Heater is created on sensor output
;M307 Heater type is catagorised
;M140 or M141 to say if bed or chamber
;M143 to configure max temp

G4 S1 ; wait for board
;nozzle heater
M308 S1 P"121.temp1" Y"pt1000" A"Nozzle"                              ; configure sensor 1 as thermistor on pin temp1
M950 H1 C"121.out0" T1                                                ; create heater and map sensor 1 (toolboard)
M307 H1 R2.346 K0.580:0.000 D3.78 E1.35 S1.00 B0 V25.0                ; Disable Bang Bang
M143 H1 S360                                                          ;set max temp
;bed heater
M308 S0 P"0.temp0" Y"thermistor" A"Bed" T100000 B3950                 ; configure sensor 0 as thermistor on pin temp1
M950 H0 C"out9" T0                                                    ; create bed heater output on out1 and map it to sensor 0
M307 H0 R0.593 K0.350:0.000 D3.19 E1.35 S1.00 B0                      ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                               ; map heated bed to heater 0
M143 H0 S130                                                          ;set max temp
;chamber heater
M308 S2 P"temp3" Y"thermistor" A"Chamber" T100000 B4267 C7.06e-8      ; configure sensor 2 as thermistor on pin temp2    
M950 H2 C"out0" T2                                                    ;Create chamber heater on out0 (Normally bed output) and map it to temp0 on mainboard
M307 H2 R0.7 K2.772:0.000 D15 E1.35 S1.00 B1                          ;disable bang bang and configure heate
M141 H2                                                               ; Set as chamber heater
M143 H2 S80                                                           ; Set max temp
M570 H2 P1500 T20                                                      ;Set weakened heater fault detection as heater is MUCH slower to react to power changes P=time before fault T=temp detla allowance


;Heatsink ambient sensor
;M308 S3 P"121.temp0" Y"thermistor" A"Heatsink" T100000 B4267 C7.06e-8 ; configure sensor 2 as thermistor on pin temp2 on TOOLBOARD

;Electronic chamber sensor 
M308 S4 P"temp2" Y"thermistor" A"Electronics Chamber" T100000 B4267 C7.06e-8

;Chamber Sensor Top
M308 S5 P"temp1" Y"thermistor" A"Chamber Top" T100000 B4267 C7.06e-8      ; configure sensor 2 as thermistor on pin temp2    


;███████████████████████████████████████████████████████████████████████████████████
;Fan Control


;nozzle heatsink
M950 F0 C"121.out1" Q500
M106 P0 S0 B0.5 C"Nozzle Fan"                                             ;Thermostatically controlled (35C+) Heatsink fan on out1 on Toolboard

;User Controlable
;M950 F1 C"121.out2" Q1000                                               ;Part cooling fan (5V) on Toolboard
;M106 P1 S0 L65 X255 H-1 B0.1                                            ;later date replace with tacho equipped 5v

;Chamber Fans
M950 F4 C"!out4+out4.tach"                                              ;Chamber 12032 fans connected to 4 wire on mainboard
M950 F5 C"!out5+out5.tach"
M950 F6 C"!out6+out6.tach"
M950 F7 C"!out7+io7.in"                                                 ;Chamber 12032 fans connected to 2 wire output and io7 as input for tach on mainboard

;Exhaust fans
M950 F8 C"out8"                                                         ;Exhaust fan with carbon filter
M106 P8 S255 B0.5 H5 T70 C"Exhaust Fan"                                 ;Set thermostatic control to 50C


;███████████████████████████████████████████████████████████████████████████████████
;Tools
M563 P0 S"Nozzle" D0 H1 F0                                            ;Create tool0 called heater using the first extruder (0) in the list using heater 1 and fan 1
G10 P0 X0 Y0 Z0 R0 S0                                                 ;set active and standby to 0
T0                                                                    ;choose tool 0 as default

;███████████████████████████████████████████████████████████████████████████████████
;Quality enchancements
M593 P"EI2" F45                                                       ; input shaping
M572 D0 S0.028                                                         ; pressure advance
M309 S0.024 P0                                                        ; material feedforward


;███████████████████████████████████████████████████████████████████████████████████
;Tertiary
M150 E0 R255 U255 B255 P255 S20 ;Setup finished set to white
