#line 1 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/Ejemplos y Utilidades/ejemplos mikroC/ultrasonico hc-sr04/PingDemo.c"
#pragma orgall 0x1000
#line 13 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/Ejemplos y Utilidades/ejemplos mikroC/ultrasonico hc-sr04/PingDemo.c"
float Ping();

float x = 0;

void main() org 0x1000
{

TRISA = 0b00000000;
TRISB = 0b00000001;
TRISC = 0b00000001;
ADCON1 = 0b00001111;


PORTA = 0b00000000;
PORTB = 0b00000000;
PORTC = 0b00000000;

UART1_Init(9600);
delay_ms(100);

while(1)
{
char txt[50];
x = Ping();
floattostr(x,txt);
strcat(txt, " cm.");
UART1_Write_Text(txt);
UART1_Write(10);
UART1_Write(13);
delay_ms(1000);
}
}

float Ping()
{
float x = 0;
int time_us = 0;
int timeOut = 14000;
 PORTB.f1  = 0;
delay_us(5);
 PORTB.f1  = 1;
delay_us(10);
 PORTB.f1  = 0;

while( PORTB.f0  == 0);

while(( PORTB.f0  == 1)&& (time_us<=timeOut))
{
delay_us(1);
time_us++;
}

if(time_us >= timeOut)
{
x = 0;
}
else
{
x = ((time_us*1.08)*0.03436);
}
return x;
}
