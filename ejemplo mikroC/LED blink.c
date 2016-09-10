 #pragma orgall 0x1000
 
 //mas informacion sobre las directivas org en http://download.mikroe.com/documents/compilers/mikroc/pic/help/goto_statement.htm
 //el bootloader termina en la direccion de memoria ox1000, escribir el codigo a partir de aqui.

void main()  org 0x1000
{
TRISC = 0b00000001;
PORTC = 0b00000000;

while(1)
{
PORTC.f1 = 0;
delay_ms(1000);
PORTC.f1 = 1;
delay_ms(1000);
}

}