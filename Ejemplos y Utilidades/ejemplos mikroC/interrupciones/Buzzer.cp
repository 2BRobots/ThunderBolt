#line 1 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/Buzzer/Buzzer.c"
#pragma orgall 0x1000
#pragma funcorg bootInterrupt 0x1000
#pragma funcorg main 0x102A
#pragma funcall main bootInterrupt
#line 6 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/Buzzer/Buzzer.c"
void interrupt()
{
if(INTCON.f1 == 1)
{
PORTC.f1 = !PORTC.f1;
delay_ms(200);
INTCON.f1 = 0;
}
}

void interrupt_low()
{

}

void main()
{
TRISA = 0b00000000;
TRISB = 0b00000001;
TRISC = 0b00000001;
ADCON1 = 0b00001111;


PORTA = 0;
PORTB = 0;
PORTC = 0;


Sound_Init(&PORTA, 0);
Sound_Play(880, 1000);

delay_ms(500);
PORTC.f2 = 1;
delay_ms(500);
PORTC.f2 = 0;


INTCON = 0b10010000;
INTCON2.f6 = 1;

while(1)
{
delay_ms(500);
PORTC.f2 = !PORTC.f2;
}
}


void bootInterrupt()
{
 asm {
 goto _main
 goto 0
 goto _interrupt
 goto 0
 goto 0
 goto 0
 goto _interrupt_low
 }
}
