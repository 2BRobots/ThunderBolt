#pragma orgall 0x1000
#define ServoPin PORTB.f0

void servo(int angulo) //para mantener el servo en su posicion esta funcion debe ser invocada cada 20 mili-segundos
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
ServoPin = 1;
delay_us(1000);
for(i = 0; i <= angulo; i++)
{
delay_us(6);
}
ServoPin = 0;
}

float x;


void main() org 0x1000
{

TRISA = 0b00000001;  //Todo el puerto A es salida
TRISB = 0b00000000;  //Todo el puerto B es salida
TRISC = 0b00000001;  //Todo el puerto C es salida, exepto el bit 0 que es entrada
ADCON1 = 0b00001110;  //Entradas analogicas desactivadas

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