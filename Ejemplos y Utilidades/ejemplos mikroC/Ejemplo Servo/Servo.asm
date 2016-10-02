
_servo:

;Servo.c,9 :: 		void servo(int angulo) //para mantener el servo en su posicion esta funcion debe ser invocada cada 20 mili-segundos
;Servo.c,12 :: 		if(angulo <= 0)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_servo_angulo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__servo18
	MOVF        FARG_servo_angulo+0, 0 
	SUBLW       0
L__servo18:
	BTFSS       STATUS+0, 0 
	GOTO        L_servo0
;Servo.c,14 :: 		angulo = 0;
	CLRF        FARG_servo_angulo+0 
	CLRF        FARG_servo_angulo+1 
;Servo.c,15 :: 		}
L_servo0:
;Servo.c,16 :: 		if (angulo >= 180)
	MOVLW       128
	XORWF       FARG_servo_angulo+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__servo19
	MOVLW       180
	SUBWF       FARG_servo_angulo+0, 0 
L__servo19:
	BTFSS       STATUS+0, 0 
	GOTO        L_servo1
;Servo.c,18 :: 		angulo = 180;
	MOVLW       180
	MOVWF       FARG_servo_angulo+0 
	MOVLW       0
	MOVWF       FARG_servo_angulo+1 
;Servo.c,19 :: 		}
L_servo1:
;Servo.c,20 :: 		ServoPin = 1;
	BSF         PORTB+0, 0 
;Servo.c,21 :: 		delay_us(600);
	MOVLW       10
	MOVWF       R12, 0
	MOVLW       88
	MOVWF       R13, 0
L_servo2:
	DECFSZ      R13, 1, 1
	BRA         L_servo2
	DECFSZ      R12, 1, 1
	BRA         L_servo2
	NOP
;Servo.c,22 :: 		for(i = 0; i <= angulo; i++)
	CLRF        R1 
	CLRF        R2 
L_servo3:
	MOVLW       128
	XORWF       FARG_servo_angulo+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__servo20
	MOVF        R1, 0 
	SUBWF       FARG_servo_angulo+0, 0 
L__servo20:
	BTFSS       STATUS+0, 0 
	GOTO        L_servo4
;Servo.c,24 :: 		delay_us(9);
	MOVLW       35
	MOVWF       R13, 0
L_servo6:
	DECFSZ      R13, 1, 1
	BRA         L_servo6
	NOP
	NOP
;Servo.c,22 :: 		for(i = 0; i <= angulo; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;Servo.c,25 :: 		}
	GOTO        L_servo3
L_servo4:
;Servo.c,26 :: 		ServoPin = 0;
	BCF         PORTB+0, 0 
;Servo.c,27 :: 		}
L_end_servo:
	RETURN      0
; end of _servo

_main:

;Servo.c,31 :: 		void main()  org 0x1000
;Servo.c,33 :: 		TRISA = 0b00000000;  //Todo el puerto A es salida
	CLRF        TRISA+0 
;Servo.c,34 :: 		TRISB = 0b00000000;  //Todo el puerto B es salida
	CLRF        TRISB+0 
;Servo.c,35 :: 		TRISC = 0b00000001;  //Todo el puerto C es salida, exepto el bit 0 que es entrada
	MOVLW       1
	MOVWF       TRISC+0 
;Servo.c,36 :: 		ADCON1 = 0b00001111;  //Entradas analogicas desactivadas
	MOVLW       15
	MOVWF       ADCON1+0 
;Servo.c,38 :: 		PORTA = 0;  //ponemos en LOW todos los bits de todos los puertos
	CLRF        PORTA+0 
;Servo.c,39 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Servo.c,40 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Servo.c,44 :: 		while(1)   //ciclo repetitivo infinito, hace esto por siempre
L_main7:
;Servo.c,46 :: 		for(x = 0; x<= 180; x++)  //movemos lentamente el servo de derecha a izquierda
	CLRF        _x+0 
	CLRF        _x+1 
L_main9:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVF        _x+0, 0 
	SUBLW       180
L__main22:
	BTFSS       STATUS+0, 0 
	GOTO        L_main10
;Servo.c,48 :: 		servo(x); //esta funcion mueve el servo al angulo indicado en un rango de 0° a 180°
	MOVF        _x+0, 0 
	MOVWF       FARG_servo_angulo+0 
	MOVF        _x+1, 0 
	MOVWF       FARG_servo_angulo+1 
	CALL        _servo+0, 0
;Servo.c,49 :: 		delay_ms(20); //esperamos 20ms antes de volver a invocar la funcion
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
;Servo.c,46 :: 		for(x = 0; x<= 180; x++)  //movemos lentamente el servo de derecha a izquierda
	INFSNZ      _x+0, 1 
	INCF        _x+1, 1 
;Servo.c,50 :: 		}
	GOTO        L_main9
L_main10:
;Servo.c,52 :: 		for(x = 180; x>= 0; x--)  //movemos lentamente el servo de izquierda a derecha
	MOVLW       180
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
L_main13:
	MOVLW       128
	XORWF       _x+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVLW       0
	SUBWF       _x+0, 0 
L__main23:
	BTFSS       STATUS+0, 0 
	GOTO        L_main14
;Servo.c,54 :: 		servo(x);
	MOVF        _x+0, 0 
	MOVWF       FARG_servo_angulo+0 
	MOVF        _x+1, 0 
	MOVWF       FARG_servo_angulo+1 
	CALL        _servo+0, 0
;Servo.c,55 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	DECFSZ      R11, 1, 1
	BRA         L_main16
;Servo.c,52 :: 		for(x = 180; x>= 0; x--)  //movemos lentamente el servo de izquierda a derecha
	MOVLW       1
	SUBWF       _x+0, 1 
	MOVLW       0
	SUBWFB      _x+1, 1 
;Servo.c,56 :: 		}
	GOTO        L_main13
L_main14:
;Servo.c,57 :: 		}
	GOTO        L_main7
;Servo.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
