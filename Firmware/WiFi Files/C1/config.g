; Configuration file for Duet WiFi powered Construct3D printer (firmware version 3.4.5)
; executed by the firmware on start-up

; General preferences
M575 P1 S1 B57600                                      ; enable support for PanelDue
G90                                                    ; send absolute coordinates...
M83                                                    ; ...but relative extruder moves
M550 P"CONSTRUCT 1"                          ; set printer name
M669 K1                                                ; select CoreXY mode

; Network Initial
M552 S0								; Remove this line of code to auto start the wifi network on powerup. Delete the ";" infront of the M552 and M586 below

; Network
;M552 S1                                                ; enable network
;M586 P0 S1                                             ; enable HTTP
;M586 P1 S0                                             ; disable FTP
;M586 P2 S0                                             ; disable Telnet

; Drives
M569 P0 S0                                             ; physical drive 0 goes backwards
M569 P1 S0                                             ; physical drive 1 goes backwards
M569 P2 S1                                             ; physical drive 2 goes forwards
M569 P3 S1                                             ; physical drive 3 goes forwards
M584 X0 Y1 Z2:4 E3                                       ; set drive mapping
M350 X16 Y16 Z16 E16 I1                                ; configure microstepping with interpolation
M92 X80.00 Y80.00 Z800.00 E397                   ; set steps per mm
M566 X2000.00 Y2000.00 Z100.00 E500.00                    ; set maximum instantaneous speed changes (mm/min)
M203 X30000.00 Y30000.00 Z1000.00 E6000.00                ; set maximum speeds (mm/min)
M201 X18000.00 Y18000.00 Z300.00 E6000.00                    ; set accelerations (mm/s^2)
M906 X1850 Y1850 Z900 E1000 I30                          ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                                ; Set idle timeout



; Axis Limits
M208 X0 Y0 Z0 S1                                       ; set axis minima
M208 X230 Y260 Z180 S0                                 ; set axis maxima

; Endstops
M574 X1 S3                                             ; configure sensorless endstop for low end on X
M574 Y2 S3                                             ; configure sensorless endstop for low end on Y
M574 Z1 S2                                             ; configure Z-probe endstop for low end on Z


; Z-Probe
M558 P8 C"zprobe.in" H2 F1200:120 A3 S0.05  T15000                  ; set Z probe type to unmodulated and the dive height + speeds
G31 P800 X0 Y-21 Z0.67; set Z probe trigger value, offset and trigger height
M557 P5 X10:200 Y20:235                             ; define mesh grid


; Heaters
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950         ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bedheat" T0 Q20                                ; create bed heater output on bedheat and map it to sensor 0
M307 H0 R0.429 K0.205:0.000 D3.04 E1.35 S1.00 B0            ; disable bang-bang mode for the bed heater and set PWM limit  M307 H0 R0.461 K0.541:0.000 D3.43 E1.35 S1.00 B0
M140 H0                                                ; map heated bed to heater 0
M143 H0 S130                                           ; set temperature limit for heater 0 to 120C
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.06e-8 ; configure sensor 1 as thermistor on pin e0temp
M950 H1 C"e0heat" T1                                   ; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 B0 R2.037 C309.3:187.4 D8.12 S1.00 V24.2       ; disable bang-bang mode for heater  and set PWM limit 
M143 H1 S322                                           ; set temperature limit for heater 1 to 280C

; Fans
M950 F0 C"fan1" Q500                                   ; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1                                         ; set fan 0 value. Thermostatic control is turned off
M950 F1 C"fan2" Q500                                   ; create fan 1 on pin fan1 and set its frequency
M106 P1 S0 H-1                                         ; set fan 1 value. Thermostatic control is turned off

; Tools
M563 P0 D0 H1 F0:1                                      ; define tool 0
G10 P0 X0 Y0 Z0                                        ; set tool 0 axis offsets
G10 P0 R0 S0                                           ; set initial tool 0 active and standby temperatures to 0C
T0                                                     ; Sets Tool0 as default

;Independent Z leveling
M671 X-5:235 Y190:190 S10 ; leadscrews locations at left (connected to Z) and right (connected to E1) of X axis


; Sensorless Homing Config
M915 X Y S3 F0 H200  

====
==Filament quality tweaks
M593 P"EI2" F20 				; input shaping
M572 D0 S0.03 					; pressure advance
M309 S0.02 P0					; material feedforward