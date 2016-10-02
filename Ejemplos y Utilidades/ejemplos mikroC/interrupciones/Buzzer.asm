
_interrupt:

;Buzzer.c,6 :: 		void interrupt()   //interrupciones de alto nivel, si se desactiva las prioridades todas las interrupciones estan aqui
;Buzzer.c,8 :: 		if(INTCON.f1 == 1)  //si INT0 se activo entonces cambio el estado del led verde
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;Buzzer.c,10 :: 		PORTC.f1 = !PORTC.f1;
	BTG         PORTC+0, 1 
;Buzzer.c,11 :: 		delay_ms(200);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       45
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_interrupt1:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt1
	DECFSZ      R12, 1, 1
	BRA         L_interrupt1
	DECFSZ      R11, 1, 1
	BRA         L_interrupt1
	NOP
	NOP
;Buzzer.c,12 :: 		INTCON.f1 = 0; //limpio la bandera de INT0, no hacerlo evitara que se active la interrupcion de nuevo
	BCF         INTCON+0, 1 
;Buzzer.c,13 :: 		}
L_interrupt0:
;Buzzer.c,14 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;Buzzer.c,16 :: 		void interrupt_low()//interrupciones de bajo nivel
;Buzzer.c,19 :: 		}
L_end_interrupt_low:
L__interrupt_low10:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low

_main:

;Buzzer.c,21 :: 		void main() //programa principal aqui
;Buzzer.c,23 :: 		TRISA = 0b00000000;
	CLRF        TRISA+0 
;Buzzer.c,24 :: 		TRISB = 0b00000001;
	MOVLW       1
	MOVWF       TRISB+0 
;Buzzer.c,25 :: 		TRISC = 0b00000001;
	MOVLW       1
	MOVWF       TRISC+0 
;Buzzer.c,26 :: 		ADCON1 = 0b00001111;
	MOVLW       15
	MOVWF       ADCON1+0 
;Buzzer.c,29 :: 		PORTA = 0;
	CLRF        PORTA+0 
;Buzzer.c,30 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Buzzer.c,31 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Buzzer.c,34 :: 		Sound_Init(&PORTA, 0); //configuramos el buzzer en el puerto A0
	MOVLW       PORTA+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	CLRF        FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;Buzzer.c,35 :: 		Sound_Play(880, 1000);  // hacemos sonar el buzzer a 880 Hz por 1 segundo
	MOVLW       112
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       232
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;Buzzer.c,37 :: 		delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;Buzzer.c,38 :: 		PORTC.f2 = 1;
	BSF         PORTC+0, 2 
;Buzzer.c,39 :: 		delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;Buzzer.c,40 :: 		PORTC.f2 = 0;
	BCF         PORTC+0, 2 
;Buzzer.c,43 :: 		INTCON = 0b10010000; //activamos la interrupcion en B0
	MOVLW       144
	MOVWF       INTCON+0 
;Buzzer.c,44 :: 		INTCON2.f6 = 1; //interrupcion en flanco de subida
	BSF         INTCON2+0, 6 
;Buzzer.c,46 :: 		while(1)   //parapadeo el led rojo indefinidamente
L_main4:
;Buzzer.c,48 :: 		delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
;Buzzer.c,49 :: 		PORTC.f2 = !PORTC.f2;
	BTG         PORTC+0, 2 
;Buzzer.c,50 :: 		}
	GOTO        L_main4
;Buzzer.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_bootInterrupt:

;Buzzer.c,54 :: 		void bootInterrupt()    //tabla de saltos para poder activar interrupciones usando un bootloader, manda llamar interrupciones y al main segun correponda
;Buzzer.c,57 :: 		goto _main
	GOTO        _main+0
;Buzzer.c,58 :: 		goto 0
	GOTO        0
;Buzzer.c,59 :: 		goto _interrupt
	GOTO        _interrupt+0
;Buzzer.c,60 :: 		goto 0
	GOTO        0
;Buzzer.c,61 :: 		goto 0
	GOTO        0
;Buzzer.c,62 :: 		goto 0
	GOTO        0
;Buzzer.c,63 :: 		goto _interrupt_low
	GOTO        _interrupt_low+0
;Buzzer.c,65 :: 		}
L_end_bootInterrupt:
	RETURN      0
; end of _bootInterrupt
