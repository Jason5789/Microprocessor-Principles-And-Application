#include "xc.inc"
GLOBAL _gcd
PSECT mytext,local,class=CODE,reloc=2
   
_gcd:
    MOVFF 0x001,LATD
    MOVFF 0x002,LATC
    MOVFF 0x003,LATB
    MOVFF 0x004,LATA
    
    Step1:
	MOVF 0x004,w
	CPFSGT 0x002
	    GOTO Step1_1
	GOTO Step1_4
    Step1_1:
	CPFSLT 0x002
	    GOTO Step1_2
	GOTO Step2
    Step1_2:
	MOVF 0x003,w
	CPFSGT 0x001
	    GOTO Step1_3
	GOTO Step1_4
    Step1_3:
	CPFSLT 0x001
	    GOTO Step1_4
	GOTO Step2
    Step1_4:
	MOVFF 0x001,0x010
	MOVF 0x003,w
	SUBWF 0x010,w
	MOVWF 0x001

	MOVFF 0x002,0x011
	MOVF 0x004,w
	SUBWFB 0x011,w
	MOVWF 0x002

	MOVF 0x004,w
	CPFSLT 0x002
	    GOTO Step1
	MOVF 0x004,w
	CPFSLT 0x001
	    GOTO Step1

	Step2:
	    MOVLW 0x00
	    CPFSEQ 0x002
		GOTO Step2_2
	Step2_1:
	    CPFSEQ 0x001
		GOTO Step2_2
	    GOTO Finish
	Step2_2:
	    MOVFF 0x001,0x011
	    MOVFF 0x002,0x012
	    MOVFF 0x003,0x001
	    MOVFF 0x004,0x002
	    MOVFF 0x011,0x003
	    MOVFF 0x012,0x004
	    GOTO Step1

       Finish:
	    MOVFF 0x003,0x001
	    MOVFF 0x004,0x002
       RETURN