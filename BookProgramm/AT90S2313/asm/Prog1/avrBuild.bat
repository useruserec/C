cd "C:\AVR\Book3\prog1\"
C:
del "C:\AVR\Book3\prog1\prog1.map"
del "C:\AVR\Book3\prog1\prog1.lst"
"C:\Program Files\Atmel\AVR Tools\AvrAssembler\avrasm32.exe" -fI  -o "C:\AVR\Book3\prog1\prog1.hex" -d "C:\AVR\Book3\prog1\prog1.obj" -e "C:\AVR\Book3\prog1\prog1.eep" -I "C:\AVR\Book3\prog1" -I "C:\Program Files\Atmel\AVR Tools\AvrAssembler\Appnotes" -w  -m "C:\AVR\Book3\prog1\prog1.map" "C:\AVR\Book3\prog1\Prog1.asm"
