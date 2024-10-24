#include "xc.inc"
GLOBAL _mysqrt
PSECT mytext,local,class=CODE,reloc=2
   
_mysqrt:
    DECF 0x001
    MOVFF 0x001,LATD
    MOVLW 0x00
    MOVWF 0x010
    
    Loop:
	INCF 0x010
	MOVF 0x010,w
	MULWF 0x010
	MOVFF PRODL,0x011
	MOVF 0x001,w
	CPFSGT 0x011
	    GOTO Loop
    
    MOVFF 0x010,0x001
   
    RETURN