DELC:
    LD HL, 0xFFFF                   ;LOAD HIGHEST ADDRESS INTO HL
                                    ;M CYCLES = 2
                                    ;T STATES = 10 (4, 3, 3)
                                    ;4 MHz E.T. = 2.50

    LD BC, 1000                     ;TEST 1KB
                                    ;M CYCLES = 2
                                    ;T STATES = 10 (4, 3, 3)
                                    ;4 MHz E.T. = 2.50

    LD D, 0                         ;CLEAR D REGISTER
                                    ;M CYCLES = 2
                                    ;T STATES = 7 (4, 3)
                                    ;4 MHz E.T. = 1.75

    LD E, D                         ;CLEAR E REGISTER
                                    ;M CYCLES = 1
                                    ;T STATES = 4
                                    ;4 MHz E.T. = 1.00 
