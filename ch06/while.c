#include <stdio.h>

int main(void)
{
    int sum = 0;
    int n = 100;
    int i = 1;
    while (i <= n) {
        sum = sum + i;
        i++;
    }
    printf("sum = %d\n", sum);
}