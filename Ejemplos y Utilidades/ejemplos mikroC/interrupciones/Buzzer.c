#pragma orgall 0x1000  //le digo al compilador que comienze al programa en la direccion de memoria 0x1000
#pragma funcorg bootInterrupt 0x1000 //pongo al principio de la memoria la funcion de salto para llamar al programa principal y la interrupcion
#pragma funcorg main 0x102A //direccion de inicio del programa principal
#pragma funcall main bootInterrupt //le digo al compilador que empieze a ejecutar el programa desde bootInterrupt, en lugar que desde el main

void interrupt()   //interrupciones de alto nivel, si se desactiva las prioridades todas las interrupciones estan aqui
{
if(INTCON.f1 == 1)  //si INT0 se activo entonces cambio el estado del led verde
{
PORTC.f1 = !PORTC.f1;
delay_ms(200);
INTCON.f1 = 0; //limpio la bandera de INT0, no hacerlo evitara que se active la interrupcion de nuevo
}
}

void interrupt_low()//interrupciones de bajo nivel
{

}

void main() //programa principal aqui
{
TRISA = 0b00000000;
TRISB = 0b00000001;
TRISC = 0b00000001;
ADCON1 = 0b00001111;


PORTA = 0;
PORTB = 0;
PORTC = 0;


Sound_Init(&PORTA, 0); //configuramos el buzzer en el puerto A0
Sound_Play(880, 1000);  // hacemos sonar el buzzer a 880 Hz por 1 segundo

delay_ms(500);
PORTC.f2 = 1;
delay_ms(500);
PORTC.f2 = 0;


INTCON = 0b10010000; //activamos la interrupcion en B0
INTCON2.f6 = 1; //interrupcion en flanco de subida

while(1)   //parapadeo el led rojo indefinidamente
{
delay_ms(500);
PORTC.f2 = !PORTC.f2;
}
}


void bootInterrupt()    //tabla de saltos para poder activar interrupciones usando un bootloader, manda llamar interrupciones y al main segun correponda
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