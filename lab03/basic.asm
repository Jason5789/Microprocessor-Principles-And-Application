List p=18f4520
	#include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

MOVLW 0xC8
MOVWF TRISA
RLCF TRISA
	
RRNCF TRISA
BTFSS TRISA,6 ;if number 6 bit is 1, skip next line
    BCF TRISA,7 ;set number 7 bit 0
BTFSC TRISA,6 ;if number 6 bit is 0, skip next line
    BSF TRISA,7 ;set number 7 bit 1
	
end