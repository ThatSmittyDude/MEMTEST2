ERROR:
    INC E                           	;ADD 1 TO E TO COUNT AN ERROR
											;M CYCLES = 1
											;T STATES = 4
											;4 MHz E.T. = 1.00

    LD A, C							;LOAD BOTTOM BIT INTO ACCUMULATOR
											;M CYCLES = 2
											;T STATES = 9 (4, 5)
											;MHz E.T. = 2.25
											
	CP 0                            	;CHECK TO SEE IF BOTTOM BYTE OF MEM COUNTER IS 0
											;M CYCLES = 2
											;T STATES = 7 (4, 3)
											;4 MHz E.T. = 1.75
											
	JP Z, OUT                       	;IF SO JUMP TO OUT
											;MET:
											;M CYCLES = 3
											;T STATES = 12 (4.3, 5)
											;4 MHz E.T. = 3.00
											;NOT MET:
											;M CYCLES = 2
											;T STATES = 7 (4, 3)
											;4 MHz E.T. = 1.75
											
	JP MAIN                         	;IF NOT 0 JUMP TO MAIN
											;M CYCLES = 3
											;T STATES = 12 (4, 3, 5)
											;4 MHz E.T. = 3.00
