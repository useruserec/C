/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.4 Standard
Automatic Program Generator
© Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
e-mail:office@hpinfotech.com

Project : Пример 10
Version : 1
Date    : 07.03.2006
Author  : Belov                           
Company : Home                            
Comments: 
Кодовый замок


Chip type           : ATtiny2313
Clock frequency     : 4,000000 MHz
Memory model        : Tiny
External SRAM size  : 0
Data Stack size     : 32
*****************************************************/

#include <tiny2313.h>
#define klfree 0x77F  // Код состояния при полностью отпущеных кнопках
#define kzad 3000     // Код задержки при сканировании
#define kandr 30      // Константа антидребезга
#define bsize 30      // Размер буфера для хранения кода

unsigned char flz;   // Флаг задержки
unsigned int bufr[bsize];   // Буфер в ОЗУ для хранения кода
#pragma warn-
eeprom unsigned char klen;          // Ячейка для хранения длины кода
eeprom unsigned int bufe[bsize];   // Буфер в EEPROM для хранения кода
#pragma warn+

// Прерывание по переполнению Таймера 1
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
   flz=1;
}

// Прерывание по совпадению в канале A Таймера 1
interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
   flz=1;
}

// Функция опроса клавиатуры и антидребезга
unsigned int incod (void)
{
   unsigned int cod0=0;
   unsigned int cod1;
   unsigned char k;
   
   for (k=0; k<kandr; k++)
     {
       cod1=PINB&0x7;
       cod1=(cod1<<8)+(PIND&0x7F);
       if (cod0!=cod1) 
       {
          k=0;
          cod0=cod1;
       }
     }
   return cod1;
}


// Процедура формирования задержки
void wait (unsigned char kodz)
{
   if (kodz==1) TIMSK=0x40;     // Выбор маски прерываний по таймеру
   else TIMSK=0x80;
   TCNT1=0;                    // Обнуление таймера
   flz=0;                      // Сброс флага задержки
   #asm("sei");                // Разрешаем прерывания
   if (kodz!=2) while(flz==0); // Цикл задержки
}


// Основная функция
void main(void)
{
unsigned char ii;  // Указатель массива
unsigned char i;   // Вспомогательный указатель
unsigned int codS; // Старый код

PORTB=0xE7;  // Порт B
DDRB=0x18;

PORTD=0x7F;  // Порт D
DDRD=0x00;

TCCR1A=0x00;  // Таймер/Счетчик 1
TCCR1B=0x03;
TCNT1=0;
OCR1A=kzad;

ACSR=0x80;    // Аналоговый компаратор

while (1)
      {
m1:     while (incod() != klfree); // Ожидание отпускания кнопок
        while (incod() == klfree); // Ожидание нажатия кнопок
        ii=0;
m2:     #asm("cli");               // Запрещаем прерывания
        wait(1);                   // Задержка 1-го типа
        codS=incod();              // Ввод кода и запись, как старого
        bufr[ii++]=codS;           // Запись очередного кода в буфер
        if (ii>=bsize) goto m4;    // Проверка конца буфера
        
        wait(2);                        // Задержка 2-го типа
m3:     if (incod() != codS) goto m2;   // Проверка не изменилось ли состояние
        if (flz==0) goto m3;         // Проверка окончания контрольного промежутка времени
        
m4:     if (PINB.7==1) goto comp;       // Проверка переключателя режимов

//------------------------------ Запись кода в EEPROM
        klen=ii;                                // Запись длины кода
        for (i=0; i<ii; i++)  bufe[i]=bufr[i];  // Запись всех байтов кода
        goto zamok;

//------------------------------ Проверка кода
comp:   if (klen!=ii) goto m1;              // Проверка длины кода
        for (i=0; i<ii; i++)  if (bufe[i]!=bufr[i]) goto m1;  // Проверка самого кода


//------------------------------ Открывание замка
zamok:  PORTB.4=1;        // Открываем замок
        wait(3);          // Задержка 3-го типа
        PORTB.4=0;        // Закрываем замок
      };
}
