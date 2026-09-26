/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.4 Standard
Automatic Program Generator
© Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
e-mail:office@hpinfotech.com

Project : 
Version : 
Date    : 10.01.2006
Author  : Belov                           
Company : Home                            
Comments: 


Chip type           : AT90S2313
Clock frequency     : 4,000000 MHz
Memory model        : Tiny
External SRAM size  : 0
Data Stack size     : 32
*****************************************************/

#include <90s2313.h>

// Declare your global variables here
unsigned char rab;

// Timer 1 output compare interrupt service routine
interrupt [TIM1_COMP] void timer1_comp_isr(void)
{
   if (PIND.0==1)  // Проверка состояния переключателя
     { 
     rab = rab >> 1;  // Сдвиг разрядов
     if (rab==0) rab = 0b10000000;  // Сдвиг вправо
     }  
   else
     { 
     rab = rab << 1;  // Сдвиг разрядов
     if (rab==0) rab = 0b00000001;  // Сдвиг влево
     }  
     PORTB=rab^0xFF;  // Запись в порт с инверсией
}

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=1 State6=1 State5=1 State4=1 State3=1 State2=1 State1=1 State0=1 
PORTB=0xFF;
DDRB=0xFF;

// Port D initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTD=0x7F;
DDRD=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
TCCR0=0x00;
TCNT0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 3,906 kHz
// Mode: Normal top=FFFFh
// OC1 output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
TCCR1A=0x00;
TCCR1B=0x0D;
TCNT1H=0x00;
TCNT1L=0x00;
//OCR1H=0x03;
//OCR1L=0xD0;
OCR1=976;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
GIMSK=0x00;
MCUCR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x40;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;

rab=0b00010000;

// Global enable interrupts
#asm("sei")

while (1) {};
}
