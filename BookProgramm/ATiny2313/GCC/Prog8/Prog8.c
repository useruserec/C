/*****************************************************
Project : Prog 8
Comments: Сигнализатор "Семь нот"
*****************************************************/

#include <avr/io.h>
//#include <avr/iotn2313.h>
#include <avr/pgmspace.h>
//#include <avr/progmem.h>

// Объявление и инициализация массива коэффициентов деления
unsigned int __attribute__ ((progmem)) tabkd[7] = {4748,4480,4228,3992,3768,3556,3356};


int main(void)
{
unsigned char count;  // Определяем переменную count
unsigned char temp;  // Определяем переменную temp

PORTB=0x08;   // Инициализация порта PB
DDRB=0x08;

PORTD=0x7F;   // Инициализация порта PD
DDRD=0x00;

ACSR=0x80;   // Инициализация (отключение) компаратора

TCCR1A=0x00;   // Инициализация таймера счетчика T1
TCCR1B=0x09;

while (1)
      {
m1:   temp=PIND;
      for (count=0; count<7; count++)
        {
        if ((temp&1)==0) goto m2;
        temp >>= 1;
        }
      TCCR1A=0x00;
      goto m1;
m2:   
      OCR1A=tabkd[count];
      TCCR1A=0x40;
      };
}
