cd "C:\AVR\Book3\Prog3\"
C:
del "C:\AVR\Book3\Prog3\prog3.map"
del "C:\AVR\Book3\Prog3\prog3.lst"
"C:\Program Files\Atmel\AVR Tools\AvrAssembler\avrasm32.exe" -fI  -o "C:\AVR\Book3\Prog3\prog3.hex" -d "C:\AVR\Book3\Prog3\prog3.obj" -e "C:\AVR\Book3\Prog3\prog3.eep" -I "C:\AVR\Book3\Prog3" -I "C:\Program Files\Atmel\AVR Tools\AvrAssembler\Appnotes" -w  -m "C:\AVR\Book3\Prog3\prog3.map" "C:\AVR\Book3\Prog3\Prog3.asm"
