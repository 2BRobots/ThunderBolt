#pragma orgall 0x1000

//ejemplo de como manipular de forma sencilla un solo servomotor de 180°, este codigo desperdicia mucho los recursos del microcontrolador
// es solo con fines demostrativos, para hacer una funcion que soporte mas servos y ademas sea mas eficiente se deben usar
//los timers e interrupciones del microcontrolador. Esta informacion la puede encontrar en el datasheet.

#define ServoPin PORTB.f0   //Aqui se define a que pin conectaremos el servo, en esta caso en B0

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
delay_us(600);
for(i = 0; i <= angulo; i++)
{
delay_us(9);
}
ServoPin = 0;
}

int x;

void main()  org 0x1000
{
TRISA = 0b00000000;  //Todo el puerto A es salida
TRISB = 0b00000000;  //Todo el puerto B es salida
TRISC = 0b00000001;  //Todo el puerto C es salida, exepto el bit 0 que es entrada
ADCON1 = 0b00001111;  //Entradas analogicas desactivadas

PORTA = 0;  //ponemos en LOW todos los bits de todos los puertos
PORTB = 0;
PORTC = 0;



while(1)   //ciclo repetitivo infinito, hace esto por siempre
{
for(x = 0; x<= 180; x++)  //movemos lentamente el servo de derecha a izquierda
{
servo(x); //esta funcion mueve el servo al angulo indicado en un rango de 0° a 180°
delay_ms(20); //esperamos 20ms antes de volver a invocar la funcion
}

for(x = 180; x>= 0; x--)  //movemos lentamente el servo de izquierda a derecha
{
servo(x);
delay_ms(20);
}
}
}