cd "C:\AVR\Book3\Prog2\"
C:
del "C:\AVR\Book3\Prog2\prog2.map"
del "C:\AVR\Book3\Prog2\prog2.lst"
"C:\Program Files\Atmel\AVR Tools\AvrAssembler\avrasm32.exe" -fI  -o "C:\AVR\Book3\Prog2\prog2.hex" -d "C:\AVR\Book3\Prog2\prog2.obj" -e "C:\AVR\Book3\Prog2\prog2.eep" -I "C:\AVR\Book3\Prog2" -I "C:\Program Files\Atmel\AVR Tools\AvrAssembler\Appnotes" -w  -m "C:\AVR\Book3\Prog2\prog2.map" "C:\AVR\Book3\Prog2\prog2.asm"
