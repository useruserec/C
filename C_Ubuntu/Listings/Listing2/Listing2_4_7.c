#include <stdio.h>
void two(void)
{
    printf("Два\n");
}
void one_three(void)
{
    printf("Один\n");
    two();
    printf("Три\n");
}
int main(void)
{
    printf("Начать сейчас:\n");
    one_three();
    printf("Порядок!\n");
    return 0;
}