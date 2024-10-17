List p=18f4520
	#include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0
	
Sub_Mul macro xh,xl,yh,yl
 
    MOVLW xl
    MOVWF 0x001
    MOVLW yl
    SUBWF 0x001,w
    MOVWF 0x001
    
    MOVLW xh
    MOVWF 0x000
    MOVLW yh
    SUBWFB 0x000,w
    MOVWF 0x000
    
    MOVF 0x000,w
    MULWF 0x001
    MOVFF PRODH,0x002
    MOVFF PRODL,0x003
    
    endm

Sub_Mul 0x03,0xA5,0x02,0xA7

end