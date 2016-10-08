#pragma orgall 0x1000  //le digo al compilador que comienze al programa en la direccion de memoria 0x1000
#pragma funcorg bootInterrupt 0x1000 //pongo al principio de la memoria la funcion de salto para llamar al programa principal y la interrupcion
#pragma funcorg main 0x102A //direccion de inicio del programa principal
#pragma funcall main bootInterrupt //le digo al compilador que empieze a ejecutar el programa desde bootInterrupt, en lugar que desde el main
 

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
TMR0H   = 0x15;
TMR0L   = 0xA0;
INTCON = 0b11100000;
RCON.f7 = 0;
T0CON.f7 = 1;
 
while(1)
 {
 }
}

void bootInterrupt()    //tabla de saltos para poder activar interrupciones usando un bootloader, manda llamar interrupciones y al main segun correponda
{
   asm {
   goto _main
   goto 0
   goto _interrupt
   }
}