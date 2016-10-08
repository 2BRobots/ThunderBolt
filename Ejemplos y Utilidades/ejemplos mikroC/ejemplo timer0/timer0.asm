
_interrupt:

;timer0.c,7 :: 		void interrupt()
;timer0.c,9 :: 		if (INTCON.f2 == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;timer0.c,11 :: 		T0CON.f7 = 0;
	BCF         T0CON+0, 7 
;timer0.c,12 :: 		INTCON.f2 = 0;
	BCF         INTCON+0, 2 
;timer0.c,13 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;timer0.c,14 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;timer0.c,15 :: 		PORTC.f1 = !PORTC.f1;
	BTG         PORTC+0, 1 
;timer0.c,16 :: 		T0CON.f7 = 1;
	BSF         T0CON+0, 7 
;timer0.c,17 :: 		}
L_interrupt0:
;timer0.c,18 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;timer0.c,23 :: 		void main()
;timer0.c,25 :: 		TRISA= 0b00000000;
	CLRF        TRISA+0 
;timer0.c,26 :: 		TRISB= 0b00000000;
	CLRF        TRISB+0 
;timer0.c,27 :: 		TRISC= 0b00000001;
	MOVLW       1
	MOVWF       TRISC+0 
;timer0.c,29 :: 		PORTA = 0;
	CLRF        PORTA+0 
;timer0.c,30 :: 		PORTB = 0;
	CLRF        PORTB+0 
;timer0.c,31 :: 		PORTC = 0;
	CLRF        PORTC+0 
;timer0.c,33 :: 		T0CON = 0b00000001;
	MOVLW       1
	MOVWF       T0CON+0 
;timer0.c,34 :: 		TMR0H   = 0x15;
	MOVLW       21
	MOVWF       TMR0H+0 
;timer0.c,35 :: 		TMR0L   = 0xA0;
	MOVLW       160
	MOVWF       TMR0L+0 
;timer0.c,36 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;timer0.c,37 :: 		RCON.f7 = 0;
	BCF         RCON+0, 7 
;timer0.c,38 :: 		T0CON.f7 = 1;
	BSF         T0CON+0, 7 
;timer0.c,40 :: 		while(1)
L_main1:
;timer0.c,42 :: 		}
	GOTO        L_main1
;timer0.c,43 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_bootInterrupt:

;timer0.c,45 :: 		void bootInterrupt()    //tabla de saltos para poder activar interrupciones usando un bootloader, manda llamar interrupciones y al main segun correponda
;timer0.c,48 :: 		goto _main
	GOTO        _main+0
;timer0.c,49 :: 		goto 0
	GOTO        0
;timer0.c,50 :: 		goto _interrupt
	GOTO        _interrupt+0
;timer0.c,52 :: 		}
L_end_bootInterrupt:
	RETURN      0
; end of _bootInterrupt
