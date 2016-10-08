
_main:

;PingDemo.c,17 :: 		void main()  org 0x1000
;PingDemo.c,20 :: 		TRISA = 0b00000000;
	CLRF        TRISA+0 
;PingDemo.c,21 :: 		TRISB = 0b00000001;
	MOVLW       1
	MOVWF       TRISB+0 
;PingDemo.c,22 :: 		TRISC = 0b00000001;
	MOVLW       1
	MOVWF       TRISC+0 
;PingDemo.c,23 :: 		ADCON1 = 0b00001111;
	MOVLW       15
	MOVWF       ADCON1+0 
;PingDemo.c,26 :: 		PORTA = 0b00000000;
	CLRF        PORTA+0 
;PingDemo.c,27 :: 		PORTB = 0b00000000;
	CLRF        PORTB+0 
;PingDemo.c,28 :: 		PORTC = 0b00000000;
	CLRF        PORTC+0 
;PingDemo.c,30 :: 		UART1_Init(9600); //Abrimos el UART del microcontrolador (pines Rx y Tx de la tarjeta)
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;PingDemo.c,31 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;PingDemo.c,33 :: 		while(1)
L_main1:
;PingDemo.c,36 :: 		x = Ping(); //llamamos a la funcion que lee el sensor y guardamos la distancia obtenida en x
	CALL        _Ping+0, 0
	MOVF        R0, 0 
	MOVWF       _x+0 
	MOVF        R1, 0 
	MOVWF       _x+1 
	MOVF        R2, 0 
	MOVWF       _x+2 
	MOVF        R3, 0 
	MOVWF       _x+3 
;PingDemo.c,37 :: 		floattostr(x,txt); //convertimos x a una cadena de texto
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_txt_L1+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_txt_L1+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;PingDemo.c,38 :: 		strcat(txt, " cm.");  //añadimos "cm." a la cadena
	MOVLW       main_txt_L1+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L1+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_PingDemo+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_PingDemo+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;PingDemo.c,39 :: 		UART1_Write_Text(txt); //enviamos la cadena de texto mediante el UART
	MOVLW       main_txt_L1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_txt_L1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;PingDemo.c,40 :: 		UART1_Write(10); //comando ascii nueva linea (LF)
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;PingDemo.c,41 :: 		UART1_Write(13); //comando ascii retorno de carro (CR)
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;PingDemo.c,42 :: 		delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;PingDemo.c,43 :: 		}
	GOTO        L_main1
;PingDemo.c,44 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_Ping:

;PingDemo.c,46 :: 		float Ping() //Funcion encargada de leer el sensor
;PingDemo.c,48 :: 		float x = 0;
	CLRF        Ping_x_L0+0 
	CLRF        Ping_x_L0+1 
	CLRF        Ping_x_L0+2 
	CLRF        Ping_x_L0+3 
	CLRF        Ping_time_us_L0+0 
	CLRF        Ping_time_us_L0+1 
	MOVLW       176
	MOVWF       Ping_timeOut_L0+0 
	MOVLW       54
	MOVWF       Ping_timeOut_L0+1 
;PingDemo.c,51 :: 		trigPin = 0; //cambiamos el estado logico del trigger a 0
	BCF         PORTB+0, 1 
;PingDemo.c,52 :: 		delay_us(5);
	MOVLW       19
	MOVWF       R13, 0
L_Ping4:
	DECFSZ      R13, 1, 1
	BRA         L_Ping4
	NOP
	NOP
;PingDemo.c,53 :: 		trigPin = 1; //cambiamos el estado logico del trigger a 1
	BSF         PORTB+0, 1 
;PingDemo.c,54 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_Ping5:
	DECFSZ      R13, 1, 1
	BRA         L_Ping5
	NOP
	NOP
;PingDemo.c,55 :: 		trigPin = 0; //cambiamos el estado logico del trigger a 0
	BCF         PORTB+0, 1 
;PingDemo.c,57 :: 		while(echoPin == 0);  //espero a que el pin echo del sensor se ponga en 1 logico para poder empezar a contar el tiempo
L_Ping6:
	BTFSC       PORTB+0, 0 
	GOTO        L_Ping7
	GOTO        L_Ping6
L_Ping7:
;PingDemo.c,59 :: 		while((echoPin == 1)&& (time_us<=timeOut))  //mientras el pin echo este en 1 logico y no se haya agotado el tiempo maximo de espera hago:
L_Ping8:
	BTFSS       PORTB+0, 0 
	GOTO        L_Ping9
	MOVLW       128
	XORWF       Ping_timeOut_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Ping_time_us_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ping18
	MOVF        Ping_time_us_L0+0, 0 
	SUBWF       Ping_timeOut_L0+0, 0 
L__Ping18:
	BTFSS       STATUS+0, 0 
	GOTO        L_Ping9
L__Ping15:
;PingDemo.c,61 :: 		delay_us(1);  //espero 1 us
	MOVLW       3
	MOVWF       R13, 0
L_Ping12:
	DECFSZ      R13, 1, 1
	BRA         L_Ping12
	NOP
	NOP
;PingDemo.c,62 :: 		time_us++;   //por cada 1 us transcurrido incremento el acumulador, de este modo se cuantos microsegundos duro el pulso enviado desde el sensor
	INFSNZ      Ping_time_us_L0+0, 1 
	INCF        Ping_time_us_L0+1, 1 
;PingDemo.c,63 :: 		}
	GOTO        L_Ping8
L_Ping9:
;PingDemo.c,65 :: 		if(time_us >= timeOut)
	MOVLW       128
	XORWF       Ping_time_us_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       Ping_timeOut_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ping19
	MOVF        Ping_timeOut_L0+0, 0 
	SUBWF       Ping_time_us_L0+0, 0 
L__Ping19:
	BTFSS       STATUS+0, 0 
	GOTO        L_Ping13
;PingDemo.c,67 :: 		x = 0; //si el sensor agoto el tiempo maximo de espera entonces indico que la distancia es cero ya que no hay obstaculo o esta fuera de alcance
	CLRF        Ping_x_L0+0 
	CLRF        Ping_x_L0+1 
	CLRF        Ping_x_L0+2 
	CLRF        Ping_x_L0+3 
;PingDemo.c,68 :: 		}
	GOTO        L_Ping14
L_Ping13:
;PingDemo.c,71 :: 		x = ((time_us*1.08)*0.03436); //si el pulso esta dentro del rango, entonces convierto el tiempo a distancia con esta ecuacion
	MOVF        Ping_time_us_L0+0, 0 
	MOVWF       R0 
	MOVF        Ping_time_us_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       10
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       18
	MOVWF       R4 
	MOVLW       189
	MOVWF       R5 
	MOVLW       12
	MOVWF       R6 
	MOVLW       122
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       Ping_x_L0+0 
	MOVF        R1, 0 
	MOVWF       Ping_x_L0+1 
	MOVF        R2, 0 
	MOVWF       Ping_x_L0+2 
	MOVF        R3, 0 
	MOVWF       Ping_x_L0+3 
;PingDemo.c,72 :: 		}
L_Ping14:
;PingDemo.c,73 :: 		return x; //regreso el valor de la distancia en centimetros
	MOVF        Ping_x_L0+0, 0 
	MOVWF       R0 
	MOVF        Ping_x_L0+1, 0 
	MOVWF       R1 
	MOVF        Ping_x_L0+2, 0 
	MOVWF       R2 
	MOVF        Ping_x_L0+3, 0 
	MOVWF       R3 
;PingDemo.c,74 :: 		}
L_end_Ping:
	RETURN      0
; end of _Ping
