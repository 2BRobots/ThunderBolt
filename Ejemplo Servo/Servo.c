#pragma orgall 0x1000

void servo(int angulo)
{
// 1000 us = 0°
// 1500 us = 90°
// 2000 us = 180°

int i;

if(angulo <= 0)
{
angulo = 0;
}

if (angulo >= 180)
{
angulo = 180;
}

PORTC.f1 = 1;
delay_us(1000);
for(i = 0; i <= angulo; i++)
{
delay_us(6);
}
PORTC.f1 = 0;
}

int x;

void main()  org 0x1000
{
TRISA = 0b00000000;
TRISB = 0b00000000;
TRISC = 0b00000001;
ADCON1 = 0b00001111;

PORTA = 0;
PORTB = 0;
PORTC = 0;



while(1)
{
for(x = 0; x<= 180; x++)
{
servo(x);
delay_ms(20);
}

for(x = 180; x>= 0; x--)
{
servo(x);
delay_ms(20);
}
}



}

