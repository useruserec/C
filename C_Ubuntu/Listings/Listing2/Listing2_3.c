/*two_func.c - программа, использующая две функции в одном файле*/
#include <stdio.h>
void butler(void) /*  прототип функции в стандарте ISO/ANSI c */
{
    printf("Вы звонили, сэр? \n");
}
int main (void)
{
     printf("Я вызываю дворецкого.\n");
     butler();
     printf("Да. Принесите мне чай и записанные компакт-диски. \n");
     return 0;
}