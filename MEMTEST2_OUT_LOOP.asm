OUT:
    LD A, B							;LOAD HIGH BYTE INTO ACCUMULATOR
											;M CYCLES = 2
											;T STATES = 9 (4, 5)
											;MHz E.T. = 2.25
    
	CP 0                            	;CHECK TO SEE IF TOP BYTE OF MEM COUNTER IS 0
											;M CYCLES = 2
											;T STATES = 7 (4, 3)
											;4 MHz E.T. = 1.75
   
   JP NZ, MAIN                    	;JUMP BACK TO MAIN IF NOT 0
											;M CYCLES = 3
											;T STATES = 10 (4, 3, 3)
											;4 MHz E.T. = 2.50