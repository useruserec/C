@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "C:\AVR\Book3\Tiny2313\asm\Prog8\labels.tmp" -fI -W+ie -o "C:\AVR\Book3\Tiny2313\asm\Prog8\Prog8.hex" -d "C:\AVR\Book3\Tiny2313\asm\Prog8\Prog8.obj" -e "C:\AVR\Book3\Tiny2313\asm\Prog8\Prog8.eep" -m "C:\AVR\Book3\Tiny2313\asm\Prog8\Prog8.map" "C:\AVR\Book3\Tiny2313\asm\Prog8\Prog8.asm"
