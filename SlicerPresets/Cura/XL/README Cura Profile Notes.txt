Notes: This document is temporary until the next update of CURA which hopefully will include our printers, natively.


=====
== Cura Setup Information
=====


=== Cura Setup instructions
You are going to want to add a 'Custom FFF machine'. this can be added under the preferences tab and adding a 'Non-networked printer".
In the scroll tab available, look for the 'Custom' header, and inside of the drop down, the 'Custom FFF printer' can be selected. You can name your printer what ever you deem fit. We personally use 'C1' or 'C1XL' as the machine designation, and then a custom name (like 'Dave') to indicate different machines.

=== Cura addons
It is recommended to instal a few 3rd party addons to your cura installation. These can be found by clicking the 'Marketplace' tab on the top.

We recommend:
Duet RepRapFirmware Integration:	This will provide the ability to send prints directly to the printers by adding the IP address to each printer

Arc Welder:		Adds the functionality to use G2 and G3 commands. Makes prints with curved surfaces MUCH prettier and faster.

PrintJob Naming:	Allows you to get rid of the annoying CFFF_xxx naming convention cura forces people to have.

Z offset Setting:	If everything is good, this isn't needed. However, in the case that the first layer print is not perfect, and you don't want to update the Z-probe offset in the printer, this can be a very simple way to update the z offset for first layer smoothness.


=== Printer tab
X (Width):		325
Y (Depth):		370
Z (Height):		400
Build plate shape:	Rectangular
Origin at center:	no
Heated bed:		Yes
Heated build volume:	no
G-code flavour:		RepRap

=== Printhead settings
X min:			-20
Y min:			-10
X max:			10
Y max:			10
Gantry Height:		100
Number of extruders:	1
Apply Extruder offsets to Gcode:	no

=== Extruder 1 Tab
Nozzle size:			0.6
Compatible material diameter:	1.75
Nozzle offset X:		0
Nozzle offset Y:		0
Cooling fan Number:		0


=== Start G-code
; Copy paste the following code into the Start G-Code text box

M106 S0 ; Turn Fan off
M190 S{material_bed_temperature_layer_0} ;Start heating bed
M109 S150
G28; home
G1 Z15 F6000 ; move the printer down 15mm
G1 Y2 F3000
M104 S{material_print_temperature_layer_0} ;Start heating extruder
M109 S{material_print_temperature_layer_0} ;Wait for extruder to reach temp before proceeding

;prime the extruder
G1 X5 Y2 Z0.3 F6000; go to edge of build volume
G1 X60 E10 F1000 ;gentle purge start
G1 X110 E25 F1000; heavy purge
G1 X60;
G92 E0


=== End G-code
; Copy paste the following code into the End G-Code text box


;Retract the filament
G92 E1
G1 E-5 F900
;Move nozzle fast
G1 X5 Y370 F15000
;Move Bed Down
G1 Z400 F6000

;Set machine to idle
M104 S0
M140 S0
