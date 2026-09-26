/*****************************************************
Project : Prog 8
Version : 1
Date    : 31.01.2006
Author  : Belov
Company : Home
Comments: Сигнализатор "Семь нот"

Chip type           : ATtiny2313
Clock frequency     : 4,000000 MHz
*****************************************************/

#include <tiny2313.h>

// Объявление и инициализация массива коэффициентов деления
flash unsigned int tabkd[7] = {4748,4480,4228,3992,3768,3556,3356};


void main(void)
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
//      PORTB=0xF7;
      OCR1A=tabkd[count];
      TCCR1A=0x40;
      };
}
