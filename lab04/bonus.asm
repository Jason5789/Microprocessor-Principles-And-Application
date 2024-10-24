List p=18f4520
	#include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

CLRF 0x000
CLRF 0x001
MOVLW 0x18
MOVWF 0x010
MOVLW 0x00
MOVWF 0x030
CPFSGT 0x010
    GOTO finish
MOVLW 0x01
MOVWF 0x032
DCFSNZ 0x010
    GOTO finish01
	 	
LFSR 0,0x030
LFSR 1,0x032
LFSR 2,0x034
	
Loop1:
    rcall fib
    MOVFF 0x001,POSTINC2
    MOVFF 0x000,POSTINC2
    DECFSZ 0x010
	GOTO Loop1

GOTO finish

fib:
    MOVFF POSTINC0,0x001
    MOVF POSTINC1,w
    ADDWF 0x001
    MOVFF POSTINC0,0x000
    MOVF POSTINC1,w
    ADDWFC 0x000
    RETURN
    
finish01:
    MOVLW 0x01
    MOVWF 0x001
finish:
    
end