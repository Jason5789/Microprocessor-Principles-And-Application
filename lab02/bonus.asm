List p=18f4520
	#include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

MOVLW 0x00
MOVWF 0x000
MOVLW 0x11
MOVWF 0x001
MOVLW 0x22
MOVWF 0x002
MOVLW 0x33
MOVWF 0x003
MOVLW 0x44
MOVWF 0x004
MOVLW 0x55
MOVWF 0x005
MOVLW 0x66
MOVWF 0x006
MOVLW 0x33 ;find this
MOVWF 0x010

MOVLW 0x00
MOVWF 0x020 ;l
MOVWF 0x030 ;l
MOVLW 0x06
MOVWF 0x021 ;r
MOVWF 0x031 ;r
GOTO Loop
	

Loop:
    MOVFF 0x030 , 0x020 ;copy l
    MOVFF 0x031 , 0x021 ;copy r
    MOVF 0x020 , W ;l
    ADDWF 0x021 ;l+r
    CLRF 0x022
    Div2:
	RRNCF 0x021 ;(l+r)/2
	MOVF 0x021 , W ;move mid to w
	ANDLW 0b01111111 ;AND
	MOVWF 0x022 ;mid
	MOVFF 0x022, 0x023 ;copy mid
    LFSR 0, 0x000 ;find pointer
    RightSpace: ;find right space
	MOVF POSTINC0
	DECFSZ 0x023
	    GOTO RightSpace
    MOVF INDF0, W  ;now move to w
    CPFSEQ 0x010 ;skip if == w
    GOTO notEqual
	GOTO result
    notEqual:
	CPFSGT 0x010 ;skip if w>ans
	    GOTO ansSmaller
	    INCF 0x022 ;mid+1
	    MOVFF 0x022 , 0x030 ;l=mid+1
	    MOVF 0x031,w ;r
	    CPFSGT 0x030 ;if l>r skip
	    GOTO Loop
		GOTO result0
    ansSmaller:
	DECF 0x022 ;mid-1
	MOVFF 0x022 , 0x031 ;r=mid-1
	MOVF 0x031,w ;r
	    CPFSGT 0x030 ;if l>r skip
	    GOTO Loop
		GOTO result0
    result:	
	MOVLW 0xFF
	MOVWF 0x011
	GOTO Finish
    result0:
	MOVLW 0x00
	MOVWF 0x011
    Finish:
end



