
_timer0:

;timer0.c,11 :: 		void timer0() iv 0x0008 ics ICS_AUTO
;timer0.c,13 :: 		if (INTCON.f2 == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_timer00
;timer0.c,15 :: 		T0CON.f7 = 0;
	BCF         T0CON+0, 7 
;timer0.c,16 :: 		INTCON.f2 = 0;
	BCF         INTCON+0, 2 
;timer0.c,17 :: 		TMR0H         = 0x15;
	MOVLW       21
	MOVWF       TMR0H+0 
;timer0.c,18 :: 		TMR0L         = 0xA0;
	MOVLW       160
	MOVWF       TMR0L+0 
;timer0.c,19 :: 		PORTC.f1 = !PORTC.f1;
	BTG         PORTC+0, 1 
;timer0.c,20 :: 		T0CON.f7 = 1;
	BSF         T0CON+0, 7 
;timer0.c,21 :: 		}
L_timer00:
;timer0.c,22 :: 		}
L_end_timer0:
L__timer010:
	RETFIE      1
; end of _timer0

_main:

;timer0.c,27 :: 		void main() org 0x1000
;timer0.c,29 :: 		TRISA= 0b00000000;
	CLRF        TRISA+0 
;timer0.c,30 :: 		TRISB= 0b00000000;
	CLRF        TRISB+0 
;timer0.c,31 :: 		TRISC= 0b00000001;
	MOVLW       1
	MOVWF       TRISC+0 
;timer0.c,33 :: 		PORTA = 0;
	CLRF        PORTA+0 
;timer0.c,34 :: 		PORTB = 0;
	CLRF        PORTB+0 
;timer0.c,35 :: 		PORTC = 0;
	CLRF        PORTC+0 
;timer0.c,37 :: 		delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;timer0.c,39 :: 		for(i = 0; i<5;i++)
	CLRF        _i+0 
	CLRF        _i+1 
L_main2:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main12
	MOVLW       5
	SUBWF       _i+0, 0 
L__main12:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;timer0.c,41 :: 		PORTC.f2 = !PORTC.f2;
	BTG         PORTC+0, 2 
;timer0.c,42 :: 		delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;timer0.c,39 :: 		for(i = 0; i<5;i++)
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;timer0.c,43 :: 		}
	GOTO        L_main2
L_main3:
;timer0.c,44 :: 		PORTC.f2 = 0;
	BCF         PORTC+0, 2 
;timer0.c,45 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
;timer0.c,47 :: 		T0CON = 0b00000001;
	MOVLW       1
	MOVWF       T0CON+0 
;timer0.c,48 :: 		TMR0H   = 0x15;
	MOVLW       21
	MOVWF       TMR0H+0 
;timer0.c,49 :: 		TMR0L   = 0xA0;
	MOVLW       160
	MOVWF       TMR0L+0 
;timer0.c,50 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;timer0.c,51 :: 		RCON.f7 = 0;
	BCF         RCON+0, 7 
;timer0.c,52 :: 		T0CON.f7 = 1;
	BSF         T0CON+0, 7 
;timer0.c,54 :: 		while(1)
L_main7:
;timer0.c,56 :: 		}
	GOTO        L_main7
;timer0.c,57 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
