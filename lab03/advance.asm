List p=18f4520
	#include<pic18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x0

MOVLW 0x77
MOVWF 0x000
MOVLW 0x77
MOVWF 0x001
MOVLW 0x56
MOVWF 0x010
MOVLW 0x78
MOVWF 0x011
	
LFSR 0,0x000 ;first number
LFSR 1,0x030 ;up
MOVLW 0x02 ;SeperateUp counter num
MOVWF 0x035 ;SeperateUp counter

SeperateUp:
    MOVF INDF0,w
    ANDLW 0b11110000
    MOVWF INDF1
    RLNCF INDF1
    RLNCF INDF1
    RLNCF INDF1
    RLNCF POSTINC1
    MOVF POSTINC0,w
    ANDLW 0b00001111
    MOVWF POSTINC1
    DECFSZ 0x035
	GOTO SeperateUp

LFSR 0,0x010 ;secound number
LFSR 1,0x040 ;down
MOVLW 0x02 ;SeperateDown counter num
MOVWF 0x045 ;SeperateDown counter

SeperateDown:
    MOVF INDF0,w
    ANDLW 0b11110000
    MOVWF INDF1
    RLNCF INDF1
    RLNCF INDF1
    RLNCF INDF1
    RLNCF POSTINC1
    MOVF POSTINC0,w
    ANDLW 0b00001111
    MOVWF POSTINC1
    DECFSZ 0x045
	GOTO SeperateDown

LFSR 0,0x02F ;up
LFSR 2,0x060 ;16 answer
MOVLW 0x04 ;loop1 counter num
MOVWF 0x055 ;loop1 counter

;0x030*0x040 0x030*0x041 0x030*0x042...
Loop1:
MOVF POSTINC0 ;up++
LFSR 1,0x040 ;down
MOVLW 0x04  ;loop2 counter num
MOVWF 0x056 ;loop2 counter
    Loop2:
    MOVFF INDF0,0x050 ;up
    MOVFF POSTINC1,0x051 ;down
    CLRF 0x052 ;result
    MOVLW 0x04 ;mul counter num
    MOVWF 0x053 ;mul counter
    
    Mul:
	BTFSS 0x051,0 ;if ==1 , skip next line
	    GOTO LessBit0

	LessBit1: ;put result in
	    MOVF 0x050,w
	    ADDWF 0x052
	LessBit0:
	    RLNCF 0x050 ;up left
	    RRNCF 0x051 ;down right
	    BCF 0x051,7 ;set number 7 bit to 0
	    DECFSZ 0x053
		Goto Mul
		
	    MOVF 0x052,w ;move mul result to answer
	    ANDLW 0b11110000
	    MOVWF INDF2 ;first half
	    RLNCF INDF2
	    RLNCF INDF2
	    RLNCF INDF2
	    RLNCF POSTINC2
	    MOVF 0x052,w ;move mul result to answer
	    ANDLW 0b00001111
	    MOVWF POSTINC2  ;second half
	DECFSZ 0x056 ;loop 2 counter
	    GOTO Loop2
    DECFSZ 0x055 ;loop 1 counter
	GOTO Loop1
    
    
Next8F: ;7F
    MOVFF 0x07F,0x08F

Next8E: ;7E+77+7D
    MOVFF 0x07E,0x08E
    MOVF 0x077,w
    ADDWF 0x08E
    MOVF 0x07D,w
    ADDWF 0x08E
    BTFSC 0x08F,4 ;if carry
	INCF 0x08E
    BTFSS 0x08F,5 ;if carry
	GOTO Next8D
	MOVLW 0x02
	ADDWF 0x08E

Next8D: ;76+7C+6F+75+7B
    MOVFF 0x076,0x08D
    MOVF 0x07C,w
    ADDWF 0x08D
    MOVF 0x06F,w
    ADDWF 0x08D
    MOVF 0x075,w
    ADDWF 0x08D
    MOVF 0x07B,w
    ADDWF 0x08D
    BTFSC 0x08E,4 ;if carry
	INCF 0x08D
    BTFSS 0x08E,5 ;if carry
	GOTO Next8D_6
	MOVLW 0x02
	ADDWF 0x08D
    Next8D_6:
    BTFSS 0x08E,6
	GOTO Next8C
	MOVLW 0x04
	ADDWF 0x08D
    
Next8C: ;6E+74+7A+67+6D+73+79
    MOVFF 0x06E,0x08C
    MOVF 0x074,w
    ADDWF 0x08C
    MOVF 0x07A,w
    ADDWF 0x08C
    MOVF 0x067,w
    ADDWF 0x08C
    MOVF 0x06D,w
    ADDWF 0x08C
    MOVF 0x073,w
    ADDWF 0x08C
    MOVF 0x079,w
    ADDWF 0x08C
    BTFSC 0x08D,4 ;if carry
	INCF 0x08C
    BTFSS 0x08D,5 ;if carry
	GOTO Next8C_6
	MOVLW 0x02
	ADDWF 0x08C
    Next8C_6:
    BTFSS 0x08D,6 ;if carry
	GOTO Next8B
	MOVLW 0x04
	ADDWF 0x08C
    
Next8B: ;66+6C+72+78+65+6B+71
    MOVFF 0x066,0x08B
    MOVF 0x06C,w
    ADDWF 0x08B
    MOVF 0x072,w
    ADDWF 0x08B
    MOVF 0x078,w
    ADDWF 0x08B
    MOVF 0x065,w
    ADDWF 0x08B
    MOVF 0x06B,w
    ADDWF 0x08B
    MOVF 0x071,w
    ADDWF 0x08B
    BTFSC 0x08C,4 ;if carry
	INCF 0x08B
    BTFSS 0x08C,5 ;if carry
	GOTO Next8B_6
	MOVLW 0x02
	ADDWF 0x08B
    Next8B_6:
    BTFSS 0x08C,6 ;if carry
	GOTO Next8A
	MOVLW 0x04
	ADDWF 0x08B
    
Next8A: ;64+6A+70+63+69
    MOVFF 0x064,0x08A
    MOVF 0x06A,w
    ADDWF 0x08A
    MOVF 0x070,w
    ADDWF 0x08A
    MOVF 0x063,w
    ADDWF 0x08A
    MOVF 0x069,w
    ADDWF 0x08A
    BTFSC 0x08B,4 ;if carry
	INCF 0x08A
    BTFSS 0x08B,5 ;if carry
	GOTO Next8A_6
	MOVLW 0x02
	ADDWF 0x08A
    Next8A_6:
    BTFSS 0x08B,6 ;if carry
	GOTO Next89
	MOVLW 0x04
	ADDWF 0x08A
    
Next89: ;62+68+61
    MOVFF 0x062,0x089
    MOVF 0x068,w
    ADDWF 0x089
    MOVF 0x061,w
    ADDWF 0x089
    BTFSC 0x08A,4 ;if carry
	INCF 0x089
    BTFSS 0x08A,5 ;if carry
	GOTO Next89_6
	MOVLW 0x02
	ADDWF 0x089
    Next89_6:
    BTFSS 0x08A,6 ;if carry
	GOTO Next88
	MOVLW 0x04
	ADDWF 0x089
  
Next88: ;60
    MOVFF 0x060,0x088
    BTFSC 0x089,4 ;if carry
	INCF 0x088
    BTFSS 0x089,5 ;if carry
	GOTO SingleBitCounter
	MOVLW 0x02
	ADDWF 0x088

SingleBitCounter:
    MOVLW 0x08 ;SingleBit counter num
    MOVWF 0x090 ;SingleBit counter
    LFSR 0,0x088 ;first result space
    
SingleBit:
    MOVF INDF0,w ;move answer to wreg
    ANDLW 0b00001111 ;remove useless bits
    MOVWF POSTINC0 ;move ans back
    DECFSZ 0x090 ;counter-1
	GOTO SingleBit
	
    MOVLW 0x04 ;SingleBit counter num
    MOVWF 0x090 ;SingleBit counter
    LFSR 0,0x088 ;first result space
    LFSR 1,0x020 ;first answer space
    
AdjustBit: ;2 in 1
    MOVF INDF0,w ;7~4
    RLNCF INDF0
    RLNCF INDF0
    RLNCF INDF0
    RLNCF INDF0
    MOVF POSTINC0,w
    ADDWF INDF0 ;3~0
    MOVFF POSTINC0,POSTINC1
    DECFSZ 0x090
	GOTO AdjustBit
	
end