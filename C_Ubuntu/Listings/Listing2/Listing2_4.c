#include <stdio.h>
int main (void)
{
    int n, n2, n3;
    n = 5;
    n2= n * n;
    n3 = n * n2;
    printf("n = %d, n в квадрате = %d, n в кубе  = %d\n", n, n2, n3);  // симовол %d называется спецификатор
    return 0;
}