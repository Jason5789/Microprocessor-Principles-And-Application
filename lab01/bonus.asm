List p=18f4520
    #include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

MOVLW  b'10111001' ;A
MOVWF 0x000
MOVLW  0x0A ;B
MOVWF 0x001
MOVLW  0x08

Process:
    BTFSS 0x000 , 0 ;%2==0
GOTO Add
    DECF 0x01 ;%2==1

    EndAdd:
    RRNCF 0x000
    DECFSZ WREG
GOTO Process
GOTO Finish

Add:
    INCF 0x01
    BTFSS 0x000 , 1 ;%4==0
INCF 0x01
    GOTO EndAdd

Finish:
end
