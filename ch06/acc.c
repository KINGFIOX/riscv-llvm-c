#include <stdio.h>

int main(void)
{
    int sum = 0;
    int n = 100;
    for (int i = 1; i <= n; i++) {
        sum = sum + i;
    }
    printf("sum = %d\n", sum);
}