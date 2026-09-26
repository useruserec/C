@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "C:\AVR\Book3\AT90S2313\asm\Prog5\labels.tmp" -fI -W+ie -o "C:\AVR\Book3\AT90S2313\asm\Prog5\prog5.hex" -d "C:\AVR\Book3\AT90S2313\asm\Prog5\prog5.obj" -e "C:\AVR\Book3\AT90S2313\asm\Prog5\Prog5.eep" -m "C:\AVR\Book3\AT90S2313\asm\Prog5\prog5.map" "C:\AVR\Book3\AT90S2313\asm\Prog5\Prog5.asm"
