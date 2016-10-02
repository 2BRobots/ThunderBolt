#line 1 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/ejemplo timer0/timer0.c"
#pragma orgall 0x1000
#line 11 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/ejemplo timer0/timer0.c"
void timer0() iv 0x0008 ics ICS_AUTO
{
 if (INTCON.f2 == 1)
 {
 T0CON.f7 = 0;
 INTCON.f2 = 0;
 TMR0H = 0x15;
 TMR0L = 0xA0;
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
 TMR0H = 0x15;
 TMR0L = 0xA0;
 INTCON = 0b11100000;
 RCON.f7 = 0;
 T0CON.f7 = 1;

 while(1)
 {
 }
}
