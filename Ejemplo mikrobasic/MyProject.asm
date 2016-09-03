
_main:

;MyProject.mbas,7 :: 		org 0x1000
;MyProject.mbas,9 :: 		TRISC = %00000000
	CLRF        TRISC+0 
;MyProject.mbas,11 :: 		PORTC.1 = 0
	BCF         PORTC+0, 1 
;MyProject.mbas,12 :: 		PORTC.2 = 0
	BCF         PORTC+0, 2 
;MyProject.mbas,14 :: 		PWM1_Init(100000)
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       119
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;MyProject.mbas,15 :: 		PWM1_start()
	CALL        _PWM1_Start+0, 0
;MyProject.mbas,16 :: 		PWM2_Init(100000)
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       119
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;MyProject.mbas,17 :: 		PWM2_start()
	CALL        _PWM2_Start+0, 0
;MyProject.mbas,19 :: 		delay_ms(500)
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L__main1:
	DECFSZ      R13, 1, 1
	BRA         L__main1
	DECFSZ      R12, 1, 1
	BRA         L__main1
	DECFSZ      R11, 1, 1
	BRA         L__main1
	NOP
;MyProject.mbas,21 :: 		inicio:
L__main_inicio:
;MyProject.mbas,22 :: 		for x = 0 to 255 step 1
	CLRF        _x+0 
L__main4:
;MyProject.mbas,23 :: 		PWM1_set_Duty(x)
	MOVF        _x+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.mbas,24 :: 		delay_ms(10)
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L__main8:
	DECFSZ      R13, 1, 1
	BRA         L__main8
	DECFSZ      R12, 1, 1
	BRA         L__main8
;MyProject.mbas,25 :: 		next x
	MOVF        _x+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L__main7
	INCF        _x+0, 1 
	GOTO        L__main4
L__main7:
;MyProject.mbas,27 :: 		for x = 0 to 255 step 1
	CLRF        _x+0 
L__main10:
;MyProject.mbas,28 :: 		PWM2_set_Duty(x)
	MOVF        _x+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;MyProject.mbas,29 :: 		delay_ms(10)
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L__main14:
	DECFSZ      R13, 1, 1
	BRA         L__main14
	DECFSZ      R12, 1, 1
	BRA         L__main14
;MyProject.mbas,30 :: 		next x
	MOVF        _x+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L__main13
	INCF        _x+0, 1 
	GOTO        L__main10
L__main13:
;MyProject.mbas,32 :: 		for x = 255 to 0 step -1
	MOVLW       255
	MOVWF       _x+0 
L__main16:
;MyProject.mbas,33 :: 		PWM1_set_Duty(x)
	MOVF        _x+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.mbas,34 :: 		delay_ms(10)
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L__main20:
	DECFSZ      R13, 1, 1
	BRA         L__main20
	DECFSZ      R12, 1, 1
	BRA         L__main20
;MyProject.mbas,35 :: 		next x
	MOVF        _x+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       255
	ADDWF       _x+0, 1 
	GOTO        L__main16
L__main19:
;MyProject.mbas,37 :: 		for x = 255 to 0 step -1
	MOVLW       255
	MOVWF       _x+0 
L__main22:
;MyProject.mbas,38 :: 		PWM2_set_Duty(x)
	MOVF        _x+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;MyProject.mbas,39 :: 		delay_ms(10)
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L__main26:
	DECFSZ      R13, 1, 1
	BRA         L__main26
	DECFSZ      R12, 1, 1
	BRA         L__main26
;MyProject.mbas,40 :: 		next x
	MOVF        _x+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main25
	MOVLW       255
	ADDWF       _x+0, 1 
	GOTO        L__main22
L__main25:
;MyProject.mbas,42 :: 		goto inicio
	GOTO        L__main_inicio
L_end_main:
	GOTO        $+0
; end of _main
