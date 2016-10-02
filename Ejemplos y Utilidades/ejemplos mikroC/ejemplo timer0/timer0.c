#pragma orgall 0x1000
 
/*1.-Dispara un pulso ultrasonico a travez del pin "triger".
 2.-de forma coincidente empieza el conteo.
 3.-se recibe el primer sonido a travez del pin "echo".
 4.-de forma coindidente dispara interrupcion externa para detener el conteo.
 5.-el valor obtenido en el contador se multiplica por la velocidad del sonido.
 6.-regular un PWM con la distancia obtenida.*/
//Prescaler 1:4; TMR0 Preload = 5536; Interrupt Time : 20 ms

void timer0() iv 0x0008 ics ICS_AUTO
{
  if (INTCON.f2 == 1)
  {
    T0CON.f7 = 0;
    INTCON.f2 = 0;
    TMR0H         = 0x15;
    TMR0L         = 0xA0;
    PORTC.f1 = !PORTC.f1;
    T0CON.f7 = 1;
  }
}


int i;

void main() org 0x1000
{
 TRISA= 0b00000000;
 TRISB= 0b00000000;
 TRISC= 0b00000001;
 
 PORTA = 0;
 PORTB = 0;
 PORTC = 0;
 
 delay_ms(1000);
 
 for(i = 0; i<5;i++)
 {
 PORTC.f2 = !PORTC.f2;
 delay_ms(500);
 }
 PORTC.f2 = 0;
 delay_ms(100);

  T0CON = 0b00000001;
  TMR0H   = 0x15;
  TMR0L   = 0xA0;
  INTCON = 0b11100000;
  RCON.f7 = 0;
  T0CON.f7 = 1;
 
 while(1)
 {
 }
}