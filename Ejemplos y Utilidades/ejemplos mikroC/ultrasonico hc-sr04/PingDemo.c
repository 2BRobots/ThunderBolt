#pragma orgall 0x1000

/*
Este programa lee un sensor de distancia ultrasonico HC-SR04 y posteriormente envia el valor obtenido en centimetros a travez
de la terminal UART de la tarjeta. La lectura se realiza por software, para mejor rendimiento y precision se recomienda usar
los recursos por hardware que ofrece el microcontrolador.  (timers, interrupciones, modulo CCP)
*/

//Puertos que usaremos para el sensor   HC-SR04
#define echoPin PORTB.f0
#define trigPin PORTB.f1

float Ping(); //declaramos la funcion que usaremos para la lectura

float x = 0;

void main()  org 0x1000
{
//configuramos E/S, asi como modulos analogicos
TRISA = 0b00000000;
TRISB = 0b00000001;
TRISC = 0b00000001;
ADCON1 = 0b00001111;

//ponemos todos los puertos a 0, no necesario pero es una buena practica hacerlo
PORTA = 0b00000000;
PORTB = 0b00000000;
PORTC = 0b00000000;

UART1_Init(9600); //Abrimos el UART del microcontrolador (pines Rx y Tx de la tarjeta)
delay_ms(100);

while(1)
{
char txt[50]; //creamos una cadena
x = Ping(); //llamamos a la funcion que lee el sensor y guardamos la distancia obtenida en x
floattostr(x,txt); //convertimos x a una cadena de texto
strcat(txt, " cm.");  //añadimos "cm." a la cadena
UART1_Write_Text(txt); //enviamos la cadena de texto mediante el UART
UART1_Write(10); //comando ascii nueva linea (LF)
UART1_Write(13); //comando ascii retorno de carro (CR)
delay_ms(1000);
}
}

float Ping() //Funcion encargada de leer el sensor
{
float x = 0;
int time_us = 0;
int timeOut = 14000; //distancia maxima 4.81 metros. El rango maximo de estos sensores varia entre 2m y 4m. El minimo a leer son 4cm.
trigPin = 0; //cambiamos el estado logico del trigger a 0
delay_us(5);
trigPin = 1; //cambiamos el estado logico del trigger a 1
delay_us(10);
trigPin = 0; //cambiamos el estado logico del trigger a 0

while(echoPin == 0);  //espero a que el pin echo del sensor se ponga en 1 logico para poder empezar a contar el tiempo

while((echoPin == 1)&& (time_us<=timeOut))  //mientras el pin echo este en 1 logico y no se haya agotado el tiempo maximo de espera hago:
{
delay_us(1);  //espero 1 us
time_us++;   //por cada 1 us transcurrido incremento el acumulador, de este modo se cuantos microsegundos duro el pulso enviado desde el sensor
}

if(time_us >= timeOut)
{
x = 0; //si el sensor agoto el tiempo maximo de espera entonces indico que la distancia es cero ya que no hay obstaculo o esta fuera de alcance
}
else
{
x = ((time_us*1.08)*0.03436); //si el pulso esta dentro del rango, entonces convierto el tiempo a distancia con esta ecuacion
}
return x; //regreso el valor de la distancia en centimetros
}