EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:servolib
LIBS:servodriver11-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date "11 oct 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L SI4500BDY IC5
U 1 1 53AC927B
P 5850 4400
F 0 "IC5" H 5700 4850 60  0000 C CNN
F 1 "SI4500BDY" H 5850 3950 60  0000 C CNN
F 2 "" H 5850 4400 60  0000 C CNN
F 3 "" H 5850 4400 60  0000 C CNN
	1    5850 4400
	1    0    0    -1  
$EndComp
$Comp
L SI4500BDY IC6
U 1 1 53AC928A
P 5850 6600
F 0 "IC6" H 5700 7050 60  0000 C CNN
F 1 "SI4500BDY" H 5850 6150 60  0000 C CNN
F 2 "" H 5850 6600 60  0000 C CNN
F 3 "" H 5850 6600 60  0000 C CNN
	1    5850 6600
	1    0    0    -1  
$EndComp
$Comp
L MOTOR M1
U 1 1 53AC9299
P 7400 5500
F 0 "M1" H 7500 5700 60  0000 C CNN
F 1 "MOTOR" H 7600 5300 60  0000 C CNN
F 2 "" H 7400 5500 60  0000 C CNN
F 3 "" H 7400 5500 60  0000 C CNN
	1    7400 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 4100 6350 4700
Connection ~ 6350 4300
Wire Wire Line
	6350 4700 7400 4700
Wire Wire Line
	7400 6300 7400 5950
Wire Wire Line
	6350 6300 7400 6300
Wire Wire Line
	6350 6300 6350 6900
Connection ~ 6350 6500
Connection ~ 6350 6700
Connection ~ 6350 4500
Text HLabel 3700 4300 0    60   Input ~ 0
MA
Text HLabel 3700 6500 0    60   Input ~ 0
MB
Text HLabel 8350 1750 2    60   Output ~ 0
CSENSE
$Comp
L +8V #PWR019
U 1 1 53AEADFE
P 4850 1000
F 0 "#PWR019" H 4850 970 20  0001 C CNN
F 1 "+8V" H 4850 1110 30  0000 C CNN
F 2 "" H 4850 1000 60  0000 C CNN
F 3 "" H 4850 1000 60  0000 C CNN
	1    4850 1000
	1    0    0    -1  
$EndComp
$Comp
L C C6
U 1 1 53AEAE0D
P 5450 3000
F 0 "C6" H 5450 3100 40  0000 L CNN
F 1 "0,1uF" H 5456 2915 40  0000 L CNN
F 2 "~" H 5488 2850 30  0000 C CNN
F 3 "~" H 5450 3000 60  0000 C CNN
	1    5450 3000
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 53AEAE26
P 5800 3000
F 0 "C7" H 5800 3100 40  0000 L CNN
F 1 "1,0uF" H 5806 2915 40  0000 L CNN
F 2 "~" H 5838 2850 30  0000 C CNN
F 3 "~" H 5800 3000 60  0000 C CNN
	1    5800 3000
	1    0    0    -1  
$EndComp
$Comp
L C C8
U 1 1 53AEAE35
P 4550 1500
F 0 "C8" H 4550 1600 40  0000 L CNN
F 1 "33uF" H 4556 1415 40  0000 L CNN
F 2 "~" H 4588 1350 30  0000 C CNN
F 3 "~" H 4550 1500 60  0000 C CNN
	1    4550 1500
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR020
U 1 1 53AEAE44
P 5800 3400
F 0 "#PWR020" H 5800 3400 30  0001 C CNN
F 1 "GND" H 5800 3330 30  0001 C CNN
F 2 "" H 5800 3400 60  0000 C CNN
F 3 "" H 5800 3400 60  0000 C CNN
	1    5800 3400
	1    0    0    -1  
$EndComp
Connection ~ 5450 2800
Connection ~ 5800 2800
Connection ~ 5800 3200
$Comp
L R R10
U 1 1 53AEAED5
P 7450 1750
F 0 "R10" V 7530 1750 40  0000 C CNN
F 1 "1k" V 7457 1751 40  0000 C CNN
F 2 "~" V 7380 1750 30  0000 C CNN
F 3 "~" H 7450 1750 30  0000 C CNN
	1    7450 1750
	0    -1   -1   0   
$EndComp
$Comp
L C C9
U 1 1 53AEAEE4
P 7900 2150
F 0 "C9" H 7900 2250 40  0000 L CNN
F 1 "0,1uF" H 7906 2065 40  0000 L CNN
F 2 "~" H 7938 2000 30  0000 C CNN
F 3 "~" H 7900 2150 60  0000 C CNN
	1    7900 2150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 53AEAF07
P 7900 2600
F 0 "#PWR021" H 7900 2600 30  0001 C CNN
F 1 "GND" H 7900 2530 30  0001 C CNN
F 2 "" H 7900 2600 60  0000 C CNN
F 3 "" H 7900 2600 60  0000 C CNN
	1    7900 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 1750 7200 1750
Wire Wire Line
	7700 1750 8350 1750
Wire Wire Line
	7900 1950 7900 1750
Connection ~ 7900 1750
Wire Wire Line
	7900 2350 7900 2600
Wire Wire Line
	4850 4500 5300 4500
Wire Wire Line
	4850 6700 5300 6700
Connection ~ 4850 4500
$Comp
L GND #PWR022
U 1 1 53AEB06E
P 4350 7350
F 0 "#PWR022" H 4350 7350 30  0001 C CNN
F 1 "GND" H 4350 7280 30  0001 C CNN
F 2 "" H 4350 7350 60  0000 C CNN
F 3 "" H 4350 7350 60  0000 C CNN
	1    4350 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4100 4350 4100
Wire Wire Line
	4350 4100 4350 7350
Wire Wire Line
	5300 6300 4350 6300
Connection ~ 4350 6300
Wire Wire Line
	5000 6100 6500 6100
Connection ~ 6350 4700
Wire Wire Line
	7400 4700 7400 5050
Wire Wire Line
	6700 4900 6700 6300
Wire Wire Line
	5000 4900 6700 4900
Connection ~ 6700 6300
$Comp
L R R8
U 1 1 53AEB171
P 5000 5850
F 0 "R8" V 5080 5850 40  0000 C CNN
F 1 "100k" V 5007 5851 40  0000 C CNN
F 2 "~" V 4930 5850 30  0000 C CNN
F 3 "~" H 5000 5850 30  0000 C CNN
	1    5000 5850
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 53AEB180
P 5000 5150
F 0 "R7" V 5080 5150 40  0000 C CNN
F 1 "100k" V 5007 5151 40  0000 C CNN
F 2 "~" V 4930 5150 30  0000 C CNN
F 3 "~" H 5000 5150 30  0000 C CNN
	1    5000 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 6100 6500 4700
Connection ~ 6500 4700
Wire Wire Line
	5000 5400 5000 5600
Wire Wire Line
	5000 5500 4850 5500
Connection ~ 4850 5500
Connection ~ 5000 5500
$Comp
L R R4
U 1 1 53AEB394
P 4100 5050
F 0 "R4" V 4180 5050 40  0000 C CNN
F 1 "100k" V 4107 5051 40  0000 C CNN
F 2 "~" V 4030 5050 30  0000 C CNN
F 3 "~" H 4100 5050 30  0000 C CNN
	1    4100 5050
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 53AEB3A3
P 4100 6850
F 0 "R5" V 4180 6850 40  0000 C CNN
F 1 "100k" V 4107 6851 40  0000 C CNN
F 2 "~" V 4030 6850 30  0000 C CNN
F 3 "~" H 4100 6850 30  0000 C CNN
	1    4100 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 4300 4100 4800
Wire Wire Line
	4100 5300 4100 5400
Wire Wire Line
	4100 5400 4350 5400
Connection ~ 4350 5400
Wire Wire Line
	4100 6600 4100 6500
Connection ~ 4100 6500
Wire Wire Line
	4100 7100 4100 7200
Wire Wire Line
	4100 7200 4350 7200
Connection ~ 4350 7200
Wire Wire Line
	5000 4900 5000 4700
Wire Wire Line
	5000 4700 5300 4700
Wire Wire Line
	5000 6100 5000 6900
Wire Wire Line
	5000 6900 5300 6900
Wire Wire Line
	3700 4300 5300 4300
Connection ~ 4100 4300
Wire Wire Line
	3700 6500 5300 6500
$Comp
L C C14
U 1 1 5429D453
P 8100 5500
F 0 "C14" H 8100 5600 40  0000 L CNN
F 1 "0,1uF" H 8106 5415 40  0000 L CNN
F 2 "~" H 8138 5350 30  0000 C CNN
F 3 "~" H 8100 5500 60  0000 C CNN
	1    8100 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 5300 8100 5050
Wire Wire Line
	8100 5050 7400 5050
Wire Wire Line
	7400 5950 8100 5950
Wire Wire Line
	8100 5950 8100 5700
$Comp
L ACS722 IC4
U 1 1 542C4B21
P 5850 1850
F 0 "IC4" H 5700 2300 60  0000 C CNN
F 1 "ACS722" H 5800 1400 60  0000 C CNN
F 2 "" H 5800 1850 60  0000 C CNN
F 3 "" H 5800 1850 60  0000 C CNN
	1    5850 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 1750 5300 1750
Wire Wire Line
	5300 1550 4850 1550
Connection ~ 4850 1550
Wire Wire Line
	4850 1950 5300 1950
Wire Wire Line
	5300 2150 4850 2150
Connection ~ 4850 2150
$Comp
L +3,3V #PWR023
U 1 1 542C5C95
P 6800 1050
F 0 "#PWR023" H 6800 1010 30  0001 C CNN
F 1 "+3,3V" H 6800 1160 30  0000 C CNN
F 2 "" H 6800 1050 60  0000 C CNN
F 3 "" H 6800 1050 60  0000 C CNN
	1    6800 1050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 542C5CA4
P 6800 2300
F 0 "#PWR024" H 6800 2300 30  0001 C CNN
F 1 "GND" H 6800 2230 30  0001 C CNN
F 2 "" H 6800 2300 60  0000 C CNN
F 3 "" H 6800 2300 60  0000 C CNN
	1    6800 2300
	1    0    0    -1  
$EndComp
$Comp
L C C12
U 1 1 542C5DA5
P 6800 1450
F 0 "C12" H 6800 1550 40  0000 L CNN
F 1 "0,1uF" H 6806 1365 40  0000 L CNN
F 2 "~" H 6838 1300 30  0000 C CNN
F 3 "~" H 6800 1450 60  0000 C CNN
	1    6800 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 1550 6600 1550
Wire Wire Line
	6600 1550 6600 1250
Wire Wire Line
	6600 1250 6800 1250
Wire Wire Line
	6800 1250 6800 1050
Wire Wire Line
	6800 1650 6800 2300
Wire Wire Line
	6400 2150 6800 2150
Connection ~ 6800 2150
Wire Wire Line
	6400 1950 6800 1950
Connection ~ 6800 1950
Wire Wire Line
	4850 1000 4850 1750
Wire Wire Line
	4850 1950 4850 6700
Connection ~ 4850 2800
Wire Wire Line
	4850 2800 5800 2800
Wire Wire Line
	5450 3200 5800 3200
Wire Wire Line
	5800 3200 5800 3400
$Comp
L GND #PWR?
U 1 1 54397D23
P 4550 2000
F 0 "#PWR?" H 4550 2000 30  0001 C CNN
F 1 "GND" H 4550 1930 30  0001 C CNN
F 2 "" H 4550 2000 60  0000 C CNN
F 3 "" H 4550 2000 60  0000 C CNN
	1    4550 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 1300 4850 1300
Connection ~ 4850 1300
Wire Wire Line
	4550 1700 4550 2000
$EndSCHEMATC