#line 1 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/Ejemplos y Utilidades/ejemplos mikroC/ejemplo timer0/timer0.c"
#pragma orgall 0x1000
#pragma funcorg bootInterrupt 0x1000
#pragma funcorg main 0x102A
#pragma funcall main bootInterrupt
#line 7 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/Ejemplos y Utilidades/ejemplos mikroC/ejemplo timer0/timer0.c"
void interrupt()
{
 if (INTCON.f2 == 1)
 {
 T0CON.f7 = 0;
 INTCON.f2 = 0;
 TMR0H = 0;
 TMR0L = 0;
 PORTC.f1 = !PORTC.f1;
 T0CON.f7 = 1;
 }
}


int i;

void main()
{
TRISA= 0b00000000;
TRISB= 0b00000000;
TRISC= 0b00000001;

PORTA = 0;
PORTB = 0;
PORTC = 0;

T0CON = 0b00000001;
TMR0H = 0x15;
TMR0L = 0xA0;
INTCON = 0b11100000;
RCON.f7 = 0;
T0CON.f7 = 1;

while(1)
 {
 PORTC.f2 = !PORTC.f2;
 delay_ms(500);
 }
}

void bootInterrupt()
{
 asm {
 goto _main
 goto 0
 goto _interrupt
 }
}
