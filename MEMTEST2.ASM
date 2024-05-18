;=============================================================================;
;   ****MEMTEST.ASM****                                                       ;
;   UNIX TIMESTAMP: 1715525513                                                ;
;                                                                             ;
;   THIS PROGRAM LOADS 0xFF INTO EACH MEMORY ADDRESS ON THE Z80               ;
;                                                                             ;
;   AFTER THE ADDRESS IS LOADED WITH 0xFF, THE PROGRAM CHECKS THE             ;
;   ADDRESS TO SEE IF THE VALUE RETURNS 0                                     ;
;                                                                             ;
;   IF THE RETURN IS NOT THE EXPECTED VALUE, THE PROGRAM WRITES AN ERROR      ;
;   TO THE E REGISTER.                                                        ;
;                                                                             ;
;   AFTER THE ADRESSES ARE ALL CHECKED THE PROGRAM WRITES EACH                ;
;   ADDRESS BACK TO 0                                                         ;
;                                                                             ;
;                                                                             ;
;   AUTHOR: AUSTIN SMITH                                                      ;
;   GitHub.com/ThatSmittyDude                                                 ;
;   ThatSmittyDude@outlook.com                                                ;
;   passingunderyellow.com                                                    ;
;=============================================================================;

ORG 1
                                    ;0xFFFF = 65535 - HIGHEST MEMORY ADDRESS
                                    ;0xA300 = 41728 - 'SAFE' END OF TOP MEM
                                    ;DIFFERENCE =  23807 = 0x5CFF
                                    ;500 BYTES FROM TOP = 0xFE0B
                                    ;1KB FROM TOP = 0xFC17

                                    ; HL = MEMORY POINTER
                                    ; A = ACCUMULATOR
                                    ; BC = ADDRESS STORE
                                    ; E = ERROR COUNTER
DELC:
    LD HL, 0xFFFF                   ;LOAD HIGHEST ADDRESS INTO HL
                                    ;M CYCLES = 2
                                    ;T STATES = 10 (4.3,3)
                                    ;4 MHz E.T. = 2.50

    LD BC, 1000                     ;TEST 1KB
                                    ;M CYCLES = 2
                                    ;T STATES = 10 (4.3, 3)
                                    ;4 MHz E.T. = 2.50

    XOR D                           ;CLEAR D REGISTER
                                    ;M CYCLES = 1
                                    ;T STATES = 4
                                    ;4 MHz E.T. 1.00

    XOR E                           ;CLEAR E REGISTER
                                    ;M CYCLES = 1
                                    ;T STATES = 4
                                    ;4 MHz E.T. 1.00
MAIN:
    DEC HL                          ;CHANGE POINTER TO 1 ADDRESS LOWER
                                    ;M CYCLE = 1
                                    ;T STATES = 6
                                    ;4 MHz E.T. = 1.50

    LD (HL), 255                    ;LOAD 0xFF INTO ADDRESS POINTED TO BY HL
                                    ;M CYCLES = 3
                                    ;T STATES = 10 (4, 3, 3)
                                    ;4 MHz E.T. = 2.50
    
    LD A,(HL)                       ;Load the value at address HL into A
                                    ;M CYCLES = 2
                                    ;T STATES = 7 (4, 6)
                                    ;4 MHz E.T. = 1.75
    
    
    CP 0                            ;COMPARE TO 0
                                    ;M CYCLES = 2
                                    ;T STATES = 7 (4, 3)
                                    ;4 MHz E.T. = 1.75

    JR Z, ERROR                     ;IF VALUE COMES BACK 0, JUMP TO ERROR SECTION, KEEPS ERROR IN MEMORY
                                    ;MET:
                                        ;M CYCLES = 3
                                        ;T STATES = 12 (4.3, 5)
                                        ;4 MHz E.T. = 3.00
                                    ;NOT MET:
                                        ;M CYCLES = 2
                                        ;T STATES = 7 (4, 3)
                                        ;4 MHz E.T. = 1.75

    LD (HL), 0                      ;IF NOT CLEAR ADDRESS
                                    ;M CYCLES = 3
                                    ;T STATES = 10 (4, 3, 3)
                                    ;4 MHz E.T. = 2.50

    DEC BC                          ;REDUCE PROGRAM COUNTER BY 1
                                    ;M CYCLE = 1
                                    ;T STATES = 6
                                    ;4 MHz E.T. = 1.50

    LD A, C                         ;CHECK TO SEE IF BOTTOM BYE OF MEM COUNTER IS 0
                                    ;M CYCLES = 2
                                    ;T STATES = 9 (4, 5)
                                    ;MHz E.T. = 2.25

    CP 0                            ;COMPARE TO 0
                                    ;M CYCLES = 2
                                    ;T STATES = 7 (4, 3)
                                    ;4 MHz E.T. = 1.75

    JR Z, OUT                       ;JUMP TP OUT IF BOTTOM BYTE IS 0
                                    ;MET:
                                        ;M CYCLES = 3
                                        ;T STATES = 12 (4.3, 5)
                                        ;4 MHz E.T. = 3.00
                                    ;NOT MET:
                                        ;M CYCLES = 2
                                        ;T STATES = 7 (4, 3)
                                        ;4 MHz E.T. = 1.75
    
    JP MAIN                         ;JUMP BACK TO MAIN LOOP
                                    ;M CYCLES = 3
                                    ;T STATES = 12 (4, 3, 5)
                                    ;4 MHz E.T. = 3.00

ERROR:
    INC E                           ;ADD 1 TO E TO COUNT AN ERROR
									;M CYCLES = 1
									;T STATES = 4
									;4 MHz E.T. = 1.00

    LD A, C							;LOAD BOTTOM BIT INTO ACCUMULATOR
									;M CYCLES = 2
									;T STATES = 9 (4, 5)
									;MHz E.T. = 2.25
											
	CP 0                            ;CHECK TO SEE IF BOTTOM BYTE OF MEM COUNTER IS 0
									;M CYCLES = 2
									;T STATES = 7 (4, 3)
									;4 MHz E.T. = 1.75
											
	JP Z, OUT                       ;IF SO JUMP TO OUT
									;MET:
									;M CYCLES = 3
									;T STATES = 12 (4.3, 5)
									;4 MHz E.T. = 3.00
									;NOT MET:
									;M CYCLES = 2
									;T STATES = 7 (4, 3)
									;4 MHz E.T. = 1.75
											
	JP MAIN                         ;IF NOT 0 JUMP TO MAIN
									;M CYCLES = 3
									;T STATES = 12 (4, 3, 5)
									;4 MHz E.T. = 3.00


OUT:
    LD A, B							;LOAD HIGH BYTE INTO ACCUMULATOR
									;M CYCLES = 2
									;T STATES = 9 (4, 5)
									;MHz E.T. = 2.25
    
	CP 0                            ;CHECK TO SEE IF TOP BYTE OF MEM COUNTER IS 0
									;M CYCLES = 2
									;T STATES = 7 (4, 3)
									;4 MHz E.T. = 1.75
   
   JP NZ, MAIN                    	;JUMP BACK TO MAIN IF NOT 0
									;M CYCLES = 3
									;T STATES = 10 (4, 3, 3)
									;4 MHz E.T. = 2.50

END:
.END