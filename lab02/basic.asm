List p=18f4520
	#include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

LFSR 0, 0x100
LFSR 1, 0x116

MOVLW 0x01
MOVWF INDF0
MOVLW 0x00
MOVWF INDF1
MOVLW 0x06
MOVWF 0x000

Loop:
MOVF POSTINC0, W
ADDWF INDF1,W
MOVWF INDF0
MOVF POSTDEC1, W
ADDWF INDF0,W
MOVWF INDF1
DECFSZ 0x000
    GOTO Loop

end