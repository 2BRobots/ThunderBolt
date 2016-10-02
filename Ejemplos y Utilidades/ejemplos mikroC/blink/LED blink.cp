#line 1 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/ejemplo mikroC/LED blink.c"
#pragma orgall 0x1000
#line 6 "C:/Users/David Fernandez/Documents/GitHub/ThunderBolt/ejemplo mikroC/LED blink.c"
void main() org 0x1000
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
