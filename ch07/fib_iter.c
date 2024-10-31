#include <stdio.h>

long fib(int n)
{
    long arr[n + 1];
    arr[0] = 0;
    arr[1] = 1;
    for (int i = 2; i <= n; i++) {
        arr[i] = arr[i - 1] + arr[i - 2];
    }
    return arr[n];
}

int main(void)
{
    long f = fib(20);
    printf("f(20) = %ld\n", f);
    return 0;
}