# Simple Makefile
# Volker Oth (c) 1999

include $(AVR)/include/make1

########### change this lines according to your project ##################

#put the name of the target mcu here (at90s8515, at90s8535, attiny22, atmega603 etc.)
    MCU = at90s8515

#put the name of the target file here (without extension)
	TRG	= gcctest8

#put your C sourcefiles here 
	SRC	= $(TRG).c

#put additional assembler source file here
	ASRC    =

#additional libraries and object files to link
	LIB	=

#additional includes to compile
	INC	= 

#compiler flags
	CPFLAGS	= -g -O3 -Wall -Wstrict-prototypes -Wa,-ahlms=$(<:.c=.lst)

#assembler flags
	ASFLAGS = -gstabs

#linker flags
	LDFLAGS = -Wl,-Map=$(TRG).map,--cref

########### you should not need to change the following line #############
include $(AVR)/include/make2
		  
###### dependecies, add any dependencies you need here ###################

$(TRG).o : $(TRG).c