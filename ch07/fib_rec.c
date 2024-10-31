#include <stdio.h>

long fib(int n)
{
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}

int main(void)
{
    long f = fib(20);
    printf("f(20) = %ld\n", f);
    return 0;
}