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