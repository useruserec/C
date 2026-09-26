cd "C:\AVR\Book3\asm\Prog4\"
C:
del "C:\AVR\Book3\asm\Prog4\prog4.map"
del "C:\AVR\Book3\asm\Prog4\prog4.lst"
"C:\Program Files\Atmel\AVR Tools\AvrAssembler\avrasm32.exe" -fI  -o "C:\AVR\Book3\asm\Prog4\prog4.hex" -d "C:\AVR\Book3\asm\Prog4\prog4.obj" -e "C:\AVR\Book3\asm\Prog4\prog4.eep" -I "C:\AVR\Book3\asm\Prog4" -I "C:\Program Files\Atmel\AVR Tools\AvrAssembler\Appnotes" -w  -m "C:\AVR\Book3\asm\Prog4\prog4.map" "C:\AVR\Book3\asm\Prog4\Prog4.asm"
