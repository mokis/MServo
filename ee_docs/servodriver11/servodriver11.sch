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
Sheet 1 2
Title "M.Servo v1.1"
Date "11 oct 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L +8V #PWR01
U 1 1 53AC7F53
P 1200 900
F 0 "#PWR01" H 1200 870 20  0001 C CNN
F 1 "+8V" H 1200 1010 30  0000 C CNN
F 2 "" H 1200 900 60  0000 C CNN
F 3 "" H 1200 900 60  0000 C CNN
	1    1200 900 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 53AC807F
P 3250 2250
F 0 "#PWR02" H 3250 2250 30  0001 C CNN
F 1 "GND" H 3250 2180 30  0001 C CNN
F 2 "" H 3250 2250 60  0000 C CNN
F 3 "" H 3250 2250 60  0000 C CNN
	1    3250 2250
	1    0    0    -1  
$EndComp
$Comp
L +3,3V #PWR03
U 1 1 53AC8197
P 4400 900
F 0 "#PWR03" H 4400 860 30  0001 C CNN
F 1 "+3,3V" H 4400 1010 30  0000 C CNN
F 2 "" H 4400 900 60  0000 C CNN
F 3 "" H 4400 900 60  0000 C CNN
	1    4400 900 
	1    0    0    -1  
$EndComp
$Comp
L +8V #PWR04
U 1 1 53AC8529
P 1450 3100
F 0 "#PWR04" H 1450 3070 20  0001 C CNN
F 1 "+8V" H 1450 3210 30  0000 C CNN
F 2 "" H 1450 3100 60  0000 C CNN
F 3 "" H 1450 3100 60  0000 C CNN
	1    1450 3100
	1    0    0    -1  
$EndComp
$Comp
L +3,3V #PWR05
U 1 1 53AC853D
P 3850 3050
F 0 "#PWR05" H 3850 3010 30  0001 C CNN
F 1 "+3,3V" H 3850 3160 30  0000 C CNN
F 2 "" H 3850 3050 60  0000 C CNN
F 3 "" H 3850 3050 60  0000 C CNN
	1    3850 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 53AC854C
P 1450 3450
F 0 "#PWR06" H 1450 3450 30  0001 C CNN
F 1 "GND" H 1450 3380 30  0001 C CNN
F 2 "" H 1450 3450 60  0000 C CNN
F 3 "" H 1450 3450 60  0000 C CNN
	1    1450 3450
	1    0    0    -1  
$EndComp
Text Label 1750 3500 0    60   ~ 0
TX
Text Label 1750 3400 0    60   ~ 0
RX
Text Label 3100 3500 0    60   ~ 0
DTR
Text Label 3100 3300 0    60   ~ 0
SDA
Text Label 3100 3400 0    60   ~ 0
SCL
$Comp
L ATMEGA168-A IC2
U 1 1 53AC8756
P 2600 5850
F 0 "IC2" H 1850 7100 40  0000 L BNN
F 1 "ATMEGA168-A" H 3050 4450 40  0000 L BNN
F 2 "TQFP32" H 2600 5850 30  0000 C CIN
F 3 "" H 2600 5850 60  0000 C CNN
	1    2600 5850
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 53AC87B4
P 1400 5350
F 0 "C3" H 1400 5450 40  0000 L CNN
F 1 "0,1uF" H 1406 5265 40  0000 L CNN
F 2 "~" H 1438 5200 30  0000 C CNN
F 3 "~" H 1400 5350 60  0000 C CNN
	1    1400 5350
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR07
U 1 1 53AC87C3
P 1100 7450
F 0 "#PWR07" H 1100 7450 30  0001 C CNN
F 1 "GND" H 1100 7380 30  0001 C CNN
F 2 "" H 1100 7450 60  0000 C CNN
F 3 "" H 1100 7450 60  0000 C CNN
	1    1100 7450
	1    0    0    -1  
$EndComp
$Comp
L +3,3V #PWR08
U 1 1 53AC886C
P 1700 4350
F 0 "#PWR08" H 1700 4310 30  0001 C CNN
F 1 "+3,3V" H 1700 4460 30  0000 C CNN
F 2 "" H 1700 4350 60  0000 C CNN
F 3 "" H 1700 4350 60  0000 C CNN
	1    1700 4350
	1    0    0    -1  
$EndComp
Text Label 3700 5600 0    60   ~ 0
CURSENSE
Text Label 3700 5700 0    60   ~ 0
VOLTSENSE
Text Label 3700 5800 0    60   ~ 0
POSSENSE
Text Label 3700 5900 0    60   ~ 0
TEMPSENSE
Text Label 3700 6000 0    60   ~ 0
SDA
Text Label 3700 6100 0    60   ~ 0
SCL
$Comp
L C C5
U 1 1 53AC8B9D
P 5400 6800
F 0 "C5" H 5400 6900 40  0000 L CNN
F 1 "0,1uF" H 5406 6715 40  0000 L CNN
F 2 "~" H 5438 6650 30  0000 C CNN
F 3 "~" H 5400 6800 60  0000 C CNN
	1    5400 6800
	0    -1   -1   0   
$EndComp
Text Label 5750 6800 0    60   ~ 0
DTR
$Comp
L R R1
U 1 1 53AC8C17
P 5050 6400
F 0 "R1" V 5130 6400 40  0000 C CNN
F 1 "10k" V 5057 6401 40  0000 C CNN
F 2 "~" V 4980 6400 30  0000 C CNN
F 3 "~" H 5050 6400 30  0000 C CNN
	1    5050 6400
	1    0    0    -1  
$EndComp
$Comp
L +3,3V #PWR09
U 1 1 53AC8C26
P 5050 6000
F 0 "#PWR09" H 5050 5960 30  0001 C CNN
F 1 "+3,3V" H 5050 6110 30  0000 C CNN
F 2 "" H 5050 6000 60  0000 C CNN
F 3 "" H 5050 6000 60  0000 C CNN
	1    5050 6000
	1    0    0    -1  
$EndComp
Text Notes 2050 3800 0    60   ~ 0
Interface connector\nUART & I2C
$Comp
L R R2
U 1 1 53AC8DD4
P 10350 4900
F 0 "R2" V 10430 4900 40  0000 C CNN
F 1 "5k6" V 10357 4901 40  0000 C CNN
F 2 "~" V 10280 4900 30  0000 C CNN
F 3 "~" H 10350 4900 30  0000 C CNN
	1    10350 4900
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 53AC8DE3
P 10350 5600
F 0 "R3" V 10430 5600 40  0000 C CNN
F 1 "1k5" V 10357 5601 40  0000 C CNN
F 2 "~" V 10280 5600 30  0000 C CNN
F 3 "~" H 10350 5600 30  0000 C CNN
	1    10350 5600
	1    0    0    -1  
$EndComp
$Comp
L +8V #PWR010
U 1 1 53AC8E10
P 10350 4500
F 0 "#PWR010" H 10350 4470 20  0001 C CNN
F 1 "+8V" H 10350 4610 30  0000 C CNN
F 2 "" H 10350 4500 60  0000 C CNN
F 3 "" H 10350 4500 60  0000 C CNN
	1    10350 4500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 53AC8E65
P 10350 6050
F 0 "#PWR011" H 10350 6050 30  0001 C CNN
F 1 "GND" H 10350 5980 30  0001 C CNN
F 2 "" H 10350 6050 60  0000 C CNN
F 3 "" H 10350 6050 60  0000 C CNN
	1    10350 6050
	1    0    0    -1  
$EndComp
Text Label 9800 5250 0    60   ~ 0
VOLTSENSE
$Comp
L +3,3V #PWR012
U 1 1 53AC8FC3
P 6600 5450
F 0 "#PWR012" H 6600 5410 30  0001 C CNN
F 1 "+3,3V" H 6600 5560 30  0000 C CNN
F 2 "" H 6600 5450 60  0000 C CNN
F 3 "" H 6600 5450 60  0000 C CNN
	1    6600 5450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 53AC8FD2
P 6600 6150
F 0 "#PWR013" H 6600 6150 30  0001 C CNN
F 1 "GND" H 6600 6080 30  0001 C CNN
F 2 "" H 6600 6150 60  0000 C CNN
F 3 "" H 6600 6150 60  0000 C CNN
	1    6600 6150
	1    0    0    -1  
$EndComp
Text Label 8600 5650 2    60   ~ 0
POSSENSE
$Comp
L LM20 IC3
U 1 1 53AC905C
P 5900 1400
F 0 "IC3" H 5750 1750 60  0000 C CNN
F 1 "LM20" H 5800 1050 60  0000 C CNN
F 2 "" H 5900 1400 60  0000 C CNN
F 3 "" H 5900 1400 60  0000 C CNN
	1    5900 1400
	1    0    0    -1  
$EndComp
$Comp
L +3,3V #PWR014
U 1 1 53AC907E
P 5050 850
F 0 "#PWR014" H 5050 810 30  0001 C CNN
F 1 "+3,3V" H 5050 960 30  0000 C CNN
F 2 "" H 5050 850 60  0000 C CNN
F 3 "" H 5050 850 60  0000 C CNN
	1    5050 850 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 53AC909C
P 5050 2000
F 0 "#PWR015" H 5050 2000 30  0001 C CNN
F 1 "GND" H 5050 1930 30  0001 C CNN
F 2 "" H 5050 2000 60  0000 C CNN
F 3 "" H 5050 2000 60  0000 C CNN
	1    5050 2000
	1    0    0    -1  
$EndComp
Text Label 7050 1200 2    60   ~ 0
TEMPSENSE
$Sheet
S 8400 1050 1300 2250
U 53AC9255
F0 "motordriver" 50
F1 "motordriver.sch" 50
F2 "MA" I L 8400 1300 60 
F3 "MB" I L 8400 1600 60 
F4 "CSENSE" O R 9700 1450 60 
$EndSheet
Text Label 3700 6200 0    60   ~ 0
RESET
Text Label 3700 5050 0    60   ~ 0
MOSI
Text Label 3700 5150 0    60   ~ 0
MISO
Text Label 3700 5250 0    60   ~ 0
SCK
$Comp
L GND #PWR016
U 1 1 53ADBE37
P 5650 5500
F 0 "#PWR016" H 5650 5500 30  0001 C CNN
F 1 "GND" H 5650 5430 30  0001 C CNN
F 2 "" H 5650 5500 60  0000 C CNN
F 3 "" H 5650 5500 60  0000 C CNN
	1    5650 5500
	1    0    0    -1  
$EndComp
$Comp
L CONN_3X2 P2
U 1 1 53ADC0D4
P 5950 3350
F 0 "P2" H 5950 3600 50  0000 C CNN
F 1 "CONN_3X2" V 5950 3400 40  0000 C CNN
F 2 "" H 5950 3350 60  0000 C CNN
F 3 "" H 5950 3350 60  0000 C CNN
	1    5950 3350
	1    0    0    -1  
$EndComp
Text Label 5200 3200 0    60   ~ 0
MISO
Text Label 5200 3300 0    60   ~ 0
SCK
Text Label 5200 3400 0    60   ~ 0
RESET
Text Label 6450 3300 0    60   ~ 0
MOSI
$Comp
L +3,3V #PWR017
U 1 1 53ADC4F1
P 6750 3100
F 0 "#PWR017" H 6750 3060 30  0001 C CNN
F 1 "+3,3V" H 6750 3210 30  0000 C CNN
F 2 "" H 6750 3100 60  0000 C CNN
F 3 "" H 6750 3100 60  0000 C CNN
	1    6750 3100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 53ADC50A
P 6750 3550
F 0 "#PWR018" H 6750 3550 30  0001 C CNN
F 1 "GND" H 6750 3480 30  0001 C CNN
F 2 "" H 6750 3550 60  0000 C CNN
F 3 "" H 6750 3550 60  0000 C CNN
	1    6750 3550
	1    0    0    -1  
$EndComp
Text Notes 5850 3800 0    60   ~ 0
ICSP
Text Notes 3050 2500 0    60   ~ 0
3,3v Regulator
Text Notes 5500 2400 0    60   ~ 0
Temperature sensor
Text Notes 7300 6400 0    60   ~ 0
Servo position
Text Notes 9700 6400 0    60   ~ 0
Supply voltage measurement\n(12,3V -> 3,3V)
Text Label 3700 4850 0    60   ~ 0
MOTORA
Text Label 3700 4950 0    60   ~ 0
MOTORB
NoConn ~ 4200 6750
NoConn ~ 4200 6850
NoConn ~ 4200 6950
NoConn ~ 4200 7050
NoConn ~ 1450 6200
NoConn ~ 1450 6100
NoConn ~ 4200 4750
Text Label 7850 1300 0    60   ~ 0
MOTORA
Text Label 7850 1600 0    60   ~ 0
MOTORB
Text Label 9900 1450 0    60   ~ 0
CURSENSE
$Comp
L PBRC-H Q1
U 1 1 53AEB6D6
P 5050 5250
F 0 "Q1" H 4850 5650 60  0000 C CNN
F 1 "PBRC-M" H 5000 4900 60  0000 C CNN
F 2 "" H 5050 5250 60  0000 C CNN
F 3 "" H 5050 5250 60  0000 C CNN
	1    5050 5250
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 53AEC835
P 1400 5050
F 0 "C2" H 1400 5150 40  0000 L CNN
F 1 "0,1uF" H 1406 4965 40  0000 L CNN
F 2 "~" H 1438 4900 30  0000 C CNN
F 3 "~" H 1400 5050 60  0000 C CNN
	1    1400 5050
	0    -1   -1   0   
$EndComp
$Comp
L LM3480 IC1
U 1 1 53AF08C1
P 3250 1600
F 0 "IC1" H 3150 1950 60  0000 C CNN
F 1 "LM3480" H 3200 1250 60  0000 C CNN
F 2 "" H 3250 1600 60  0000 C CNN
F 3 "" H 3250 1600 60  0000 C CNN
	1    3250 1600
	0    1    1    0   
$EndComp
$Comp
L C C4
U 1 1 53AF0BD1
P 3850 1600
F 0 "C4" H 3850 1700 40  0000 L CNN
F 1 "0,1uF" H 3856 1515 40  0000 L CNN
F 2 "~" H 3888 1450 30  0000 C CNN
F 3 "~" H 3850 1600 60  0000 C CNN
	1    3850 1600
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 53AF0BE0
P 2500 1600
F 0 "C1" H 2500 1700 40  0000 L CNN
F 1 "0,1uF" H 2506 1515 40  0000 L CNN
F 2 "~" H 2538 1450 30  0000 C CNN
F 3 "~" H 2500 1600 60  0000 C CNN
	1    2500 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 3200 3850 3050
Wire Wire Line
	1100 6950 1700 6950
Connection ~ 1100 7050
Wire Wire Line
	1100 6850 1700 6850
Connection ~ 1100 6950
Connection ~ 1100 6850
Wire Wire Line
	1450 6100 1700 6100
Wire Wire Line
	1700 6200 1450 6200
Wire Wire Line
	3600 5600 4200 5600
Wire Wire Line
	3600 5700 4200 5700
Wire Wire Line
	3600 5800 4200 5800
Wire Wire Line
	3600 5900 4200 5900
Wire Wire Line
	3600 6000 4200 6000
Wire Wire Line
	3600 6100 4200 6100
Wire Wire Line
	5600 6800 6000 6800
Connection ~ 5050 6800
Wire Wire Line
	5050 6150 5050 6000
Wire Wire Line
	10350 4650 10350 4500
Wire Wire Line
	10350 6050 10350 5850
Wire Wire Line
	10350 5150 10350 5350
Wire Wire Line
	9750 5250 10350 5250
Connection ~ 10350 5250
Wire Wire Line
	5050 850  5050 1200
Wire Wire Line
	5050 1200 5400 1200
Wire Wire Line
	5400 1600 5050 1600
Wire Wire Line
	5050 1600 5050 2000
Wire Wire Line
	5050 1850 6550 1850
Wire Wire Line
	6550 1850 6550 1400
Wire Wire Line
	6550 1400 6400 1400
Connection ~ 5050 1850
Wire Wire Line
	6400 1200 7100 1200
Wire Wire Line
	3600 5050 4200 5050
Wire Wire Line
	3600 5150 4200 5150
Wire Wire Line
	3600 5250 4200 5250
Wire Wire Line
	3600 5350 4500 5350
Wire Wire Line
	5550 3200 5050 3200
Wire Wire Line
	5550 3300 5050 3300
Wire Wire Line
	5550 3400 5050 3400
Wire Wire Line
	6350 3200 6750 3200
Wire Wire Line
	6350 3300 6750 3300
Wire Wire Line
	6350 3400 6750 3400
Wire Wire Line
	6750 3200 6750 3100
Wire Wire Line
	6750 3400 6750 3550
Wire Wire Line
	3600 4850 4200 4850
Wire Wire Line
	3600 4950 4200 4950
Wire Wire Line
	3600 6350 4200 6350
Wire Wire Line
	3600 6450 4200 6450
Wire Wire Line
	3600 6550 4200 6550
Wire Wire Line
	3600 6650 4200 6650
Wire Wire Line
	3600 6750 4200 6750
Wire Wire Line
	3600 6850 4200 6850
Wire Wire Line
	3600 6950 4200 6950
Wire Wire Line
	3600 7050 4200 7050
Wire Wire Line
	3600 4750 4200 4750
Wire Wire Line
	9700 1450 10400 1450
Wire Wire Line
	8400 1300 7700 1300
Wire Wire Line
	8400 1600 7700 1600
Wire Wire Line
	4500 5450 3600 5450
Wire Wire Line
	4500 5350 4500 5050
Wire Wire Line
	5550 5250 5650 5250
Wire Wire Line
	5650 5250 5650 5500
Wire Wire Line
	3250 2150 3250 2250
Wire Wire Line
	2500 2150 2500 1800
Connection ~ 3250 2150
Connection ~ 2500 1050
Text Label 3700 6350 0    60   ~ 0
RX
Text Label 3700 6450 0    60   ~ 0
TX
$Comp
L CONN_4 P1
U 1 1 53AF575B
P 2350 3350
F 0 "P1" V 2300 3350 50  0000 C CNN
F 1 "CONN_4" V 2400 3350 50  0000 C CNN
F 2 "" H 2350 3350 60  0000 C CNN
F 3 "" H 2350 3350 60  0000 C CNN
	1    2350 3350
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 P3
U 1 1 53AF578F
P 2650 3350
F 0 "P3" V 2600 3350 50  0000 C CNN
F 1 "CONN_4" V 2700 3350 50  0000 C CNN
F 2 "" H 2650 3350 60  0000 C CNN
F 3 "" H 2650 3350 60  0000 C CNN
	1    2650 3350
	-1   0    0    1   
$EndComp
Text Notes 2650 3050 0    60   ~ 0
Top
Text Notes 2150 3050 0    60   ~ 0
Bottom
Wire Wire Line
	2000 3400 1700 3400
Wire Wire Line
	2000 3500 1700 3500
Wire Wire Line
	3000 3300 3350 3300
Wire Wire Line
	3000 3400 3350 3400
Wire Wire Line
	3000 3500 3350 3500
Wire Wire Line
	1100 7050 1700 7050
$Comp
L C C10
U 1 1 53B45252
P 1400 4800
F 0 "C10" H 1400 4900 40  0000 L CNN
F 1 "0,1uF" H 1406 4715 40  0000 L CNN
F 2 "~" H 1438 4650 30  0000 C CNN
F 3 "~" H 1400 4800 60  0000 C CNN
	1    1400 4800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1700 5050 1600 5050
Wire Wire Line
	1700 5350 1600 5350
Connection ~ 1700 5050
Connection ~ 1700 4850
Connection ~ 1700 4750
Wire Wire Line
	1100 4800 1100 7450
Wire Wire Line
	1100 5350 1200 5350
Connection ~ 1100 5350
Wire Wire Line
	1200 5050 1100 5050
Connection ~ 1100 5050
Wire Wire Line
	5050 6800 5050 6650
$Comp
L C C13
U 1 1 53B47F19
P 2200 1600
F 0 "C13" H 2200 1700 40  0000 L CNN
F 1 "1uF" H 2206 1515 40  0000 L CNN
F 2 "~" H 2238 1450 30  0000 C CNN
F 3 "~" H 2200 1600 60  0000 C CNN
	1    2200 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 1050 2200 1400
Connection ~ 2200 1050
Wire Wire Line
	2200 1800 2200 2150
Connection ~ 2500 2150
Connection ~ 2200 2150
Wire Wire Line
	2500 1050 2500 1400
$Comp
L ZENER D2
U 1 1 53B48EE9
P 1850 1600
F 0 "D2" H 1850 1700 50  0000 C CNN
F 1 "15V" H 1850 1500 40  0000 C CNN
F 2 "~" H 1850 1600 60  0000 C CNN
F 3 "~" H 1850 1600 60  0000 C CNN
	1    1850 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1850 1400 1850 1050
Wire Wire Line
	1850 1800 1850 2150
Connection ~ 1850 1050
$Comp
L DIODESCH D3
U 1 1 53B4A8A6
P 4200 1050
F 0 "D3" H 4200 1150 40  0000 C CNN
F 1 "DIODESCH" H 4200 950 40  0000 C CNN
F 2 "~" H 4200 1050 60  0000 C CNN
F 3 "~" H 4200 1050 60  0000 C CNN
	1    4200 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 4350 1700 5050
Wire Wire Line
	3450 1050 4000 1050
Wire Wire Line
	3850 1400 3850 1050
Connection ~ 3850 1050
Wire Wire Line
	3850 2150 3850 1800
Connection ~ 3850 2150
Connection ~ 4400 1050
Wire Wire Line
	1700 4800 1600 4800
Connection ~ 1700 4800
Wire Wire Line
	1200 4800 1100 4800
Wire Wire Line
	1850 2150 3850 2150
Wire Wire Line
	4400 1050 4400 900 
Text Notes 2950 3500 0    60   ~ 0
5
Text Notes 2950 3400 0    60   ~ 0
6
Text Notes 2950 3300 0    60   ~ 0
7
Text Notes 2950 3200 0    60   ~ 0
8
Text Notes 2000 3200 0    60   ~ 0
1
Text Notes 2000 3300 0    60   ~ 0
2
Text Notes 2000 3400 0    60   ~ 0
3
Text Notes 2000 3500 0    60   ~ 0
4
Text Notes 4400 5600 0    60   ~ 0
A0
Text Notes 4400 5700 0    60   ~ 0
A1
Text Notes 4400 5800 0    60   ~ 0
A2
Text Notes 4400 5900 0    60   ~ 0
A3
Text Notes 4400 4850 0    60   ~ 0
D9
Text Notes 4400 4950 0    60   ~ 0
D10
Text Label 3700 6550 0    60   ~ 0
CS
Text Label 3700 6650 0    60   ~ 0
CLK
$Comp
L DIODESCH D4
U 1 1 5429BE65
P 3600 3200
F 0 "D4" H 3600 3300 40  0000 C CNN
F 1 "DIODESCH" H 3600 3100 40  0000 C CNN
F 2 "~" H 3600 3200 60  0000 C CNN
F 3 "~" H 3600 3200 60  0000 C CNN
	1    3600 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 3200 3400 3200
Wire Wire Line
	3850 3200 3800 3200
Wire Wire Line
	1450 3300 2000 3300
$Comp
L DIODESCH D1
U 1 1 53B48FF0
P 1500 1050
F 0 "D1" H 1500 1150 40  0000 C CNN
F 1 "DIODESCH" H 1500 950 40  0000 C CNN
F 2 "~" H 1500 1050 60  0000 C CNN
F 3 "~" H 1500 1050 60  0000 C CNN
	1    1500 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 3300 1450 3450
Wire Wire Line
	1450 3200 2000 3200
Wire Wire Line
	1450 3200 1450 3100
$Comp
L C C11
U 1 1 5429CDB3
P 6600 5850
F 0 "C11" H 6600 5950 40  0000 L CNN
F 1 "0,1uF" H 6606 5765 40  0000 L CNN
F 2 "~" H 6638 5700 30  0000 C CNN
F 3 "~" H 6600 5850 60  0000 C CNN
	1    6600 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 5750 8700 5750
Wire Wire Line
	6800 5550 7250 5550
Text Label 8150 5750 0    60   ~ 0
CS
Text Label 6850 5550 0    60   ~ 0
CLK
Wire Wire Line
	1200 900  1200 1050
Wire Wire Line
	1200 1050 1300 1050
Wire Wire Line
	1700 1050 3050 1050
$Comp
L CONN_3X2 P4
U 1 1 54394926
P 7650 5700
F 0 "P4" H 7650 5950 50  0000 C CNN
F 1 "CONN_3X2" V 7650 5750 40  0000 C CNN
F 2 "" H 7650 5700 60  0000 C CNN
F 3 "" H 7650 5700 60  0000 C CNN
	1    7650 5700
	1    0    0    -1  
$EndComp
Text Notes 4400 6550 0    60   ~ 0
D2
Text Notes 4400 6650 0    60   ~ 0
D3
Text Notes 4400 6450 0    60   ~ 0
D1
Text Notes 4400 6350 0    60   ~ 0
D0
Wire Wire Line
	8050 5650 8700 5650
Wire Wire Line
	7250 5650 6600 5650
Wire Wire Line
	6600 5650 6600 5450
Wire Wire Line
	6600 6050 8800 6050
Wire Wire Line
	7250 6050 7250 5750
Wire Wire Line
	8800 6050 8800 5550
Wire Wire Line
	8800 5550 8050 5550
Connection ~ 7250 6050
Wire Wire Line
	6600 6050 6600 6150
Wire Wire Line
	3600 6200 4800 6200
Wire Wire Line
	4800 6200 4800 6800
Wire Wire Line
	4800 6800 5200 6800
$EndSCHEMATC
