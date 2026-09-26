@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "C:\AVR\Book3\Tiny2313\asm\Prog2\labels.tmp" -fI -W+ie -o "C:\AVR\Book3\Tiny2313\asm\Prog2\Prog2.hex" -d "C:\AVR\Book3\Tiny2313\asm\Prog2\Prog2.obj" -e "C:\AVR\Book3\Tiny2313\asm\Prog2\Prog2.eep" -m "C:\AVR\Book3\Tiny2313\asm\Prog2\Prog2.map" "C:\AVR\Book3\Tiny2313\asm\Prog2\Prog2.asm"
