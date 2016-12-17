
_servo:

;adc-servo.c,4 :: 		void servo(int angulo) //para mantener el servo en su posicion esta funcion debe ser invocada cada 20 mili-segundos
;adc-servo.c,7 :: 		if(angulo <= 0)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_servo_angulo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__servo12
	MOVF        FARG_servo_angulo+0, 0 
	SUBLW       0
L__servo12:
	BTFSS       STATUS+0, 0 
	GOTO        L_servo0
;adc-servo.c,9 :: 		angulo = 0;
	CLRF        FARG_servo_angulo+0 
	CLRF        FARG_servo_angulo+1 
;adc-servo.c,10 :: 		}
L_servo0:
;adc-servo.c,11 :: 		if (angulo >= 180)
	MOVLW       128
	XORWF       FARG_servo_angulo+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__servo13
	MOVLW       180
	SUBWF       FARG_servo_angulo+0, 0 
L__servo13:
	BTFSS       STATUS+0, 0 
	GOTO        L_servo1
;adc-servo.c,13 :: 		angulo = 180;
	MOVLW       180
	MOVWF       FARG_servo_angulo+0 
	MOVLW       0
	MOVWF       FARG_servo_angulo+1 
;adc-servo.c,14 :: 		}
L_servo1:
;adc-servo.c,15 :: 		ServoPin = 1;
	BSF         PORTB+0, 0 
;adc-servo.c,16 :: 		delay_us(1000);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_servo2:
	DECFSZ      R13, 1, 1
	BRA         L_servo2
	DECFSZ      R12, 1, 1
	BRA         L_servo2
	NOP
;adc-servo.c,17 :: 		for(i = 0; i <= angulo; i++)
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
	GOTO        L__servo14
	MOVF        R1, 0 
	SUBWF       FARG_servo_angulo+0, 0 
L__servo14:
	BTFSS       STATUS+0, 0 
	GOTO        L_servo4
;adc-servo.c,19 :: 		delay_us(6);
	MOVLW       23
	MOVWF       R13, 0
L_servo6:
	DECFSZ      R13, 1, 1
	BRA         L_servo6
	NOP
	NOP
;adc-servo.c,17 :: 		for(i = 0; i <= angulo; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;adc-servo.c,20 :: 		}
	GOTO        L_servo3
L_servo4:
;adc-servo.c,21 :: 		ServoPin = 0;
	BCF         PORTB+0, 0 
;adc-servo.c,22 :: 		}
L_end_servo:
	RETURN      0
; end of _servo

_main:

;adc-servo.c,27 :: 		void main() org 0x1000
;adc-servo.c,30 :: 		TRISA = 0b00000001;  //Todo el puerto A es salida
	MOVLW       1
	MOVWF       TRISA+0 
;adc-servo.c,31 :: 		TRISB = 0b00000000;  //Todo el puerto B es salida
	CLRF        TRISB+0 
;adc-servo.c,32 :: 		TRISC = 0b00000001;  //Todo el puerto C es salida, exepto el bit 0 que es entrada
	MOVLW       1
	MOVWF       TRISC+0 
;adc-servo.c,33 :: 		ADCON1 = 0b00001110;  //Entradas analogicas desactivadas
	MOVLW       14
	MOVWF       ADCON1+0 
;adc-servo.c,35 :: 		PORTA = 0;
	CLRF        PORTA+0 
;adc-servo.c,36 :: 		PORTB = 0;
	CLRF        PORTB+0 
;adc-servo.c,37 :: 		PORTC = 0;
	CLRF        PORTC+0 
;adc-servo.c,39 :: 		PORTC.f1 = 1;
	BSF         PORTC+0, 1 
;adc-servo.c,41 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;adc-servo.c,43 :: 		while(1)
L_main8:
;adc-servo.c,45 :: 		x = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _x+0 
	MOVF        R1, 0 
	MOVWF       _x+1 
	MOVF        R2, 0 
	MOVWF       _x+2 
	MOVF        R3, 0 
	MOVWF       _x+3 
;adc-servo.c,46 :: 		x = (x*180)/1023;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _x+0 
	MOVF        R1, 0 
	MOVWF       _x+1 
	MOVF        R2, 0 
	MOVWF       _x+2 
	MOVF        R3, 0 
	MOVWF       _x+3 
;adc-servo.c,47 :: 		servo(x);
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_servo_angulo+0 
	MOVF        R1, 0 
	MOVWF       FARG_servo_angulo+1 
	CALL        _servo+0, 0
;adc-servo.c,48 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
;adc-servo.c,49 :: 		}
	GOTO        L_main8
;adc-servo.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
