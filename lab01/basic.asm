List p=18f4520
    #include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

MOVLW 0x02 ;A
MOVWF 0x000
MOVLW 0x03 ;B
MOVWF 0x001
ADDWF 0x00, W
MOVWF 0x002

MOVLW 0xEE ;C
MOVWF 0x010
MOVLW 0x07 ;D
MOVWF 0x011
SUBWF 0x10, W
MOVWF 0x012

CPFSEQ 0x02 ; skip if ==
    GOTO notEqual
MOVLW 0xBB
GOTO result
notEqual:
    CPFSGT 0x02 ; skip if >
GOTO bigger
MOVLW 0xAA
GOTO result
bigger:
    MOVLW 0xCC
result:
    MOVWF 0x020
end