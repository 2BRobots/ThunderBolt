#line 1 "C:/Users/David Fernandez/Documents/adc servo/adc-servo.c"
#pragma orgall 0x1000
#line 4 "C:/Users/David Fernandez/Documents/adc servo/adc-servo.c"
void servo(int angulo)
{
int i;
if(angulo <= 0)
{
angulo = 0;
}
if (angulo >= 180)
{
angulo = 180;
}
 PORTB.f0  = 1;
delay_us(1000);
for(i = 0; i <= angulo; i++)
{
delay_us(6);
}
 PORTB.f0  = 0;
}

float x;


void main() org 0x1000
{

TRISA = 0b00000001;
TRISB = 0b00000000;
TRISC = 0b00000001;
ADCON1 = 0b00001110;

PORTA = 0;
PORTB = 0;
PORTC = 0;

PORTC.f1 = 1;

delay_ms(100);

while(1)
{
x = ADC_Read(0);
x = (x*180)/1023;
servo(x);
delay_ms(20);
}


}
