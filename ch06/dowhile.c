#include <stdio.h>

int main(void) {
  int i = 1, sum = 0, n = 100;

  do {
    sum = sum + i;
    i++;
  } while (i <= n);

  printf("sum = %d\n", sum);
}
