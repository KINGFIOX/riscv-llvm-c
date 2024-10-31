#include <stdio.h>

int main() {
  int num;

  printf("please input a number");
  scanf("%d", &num);

  int m = (num % 2 == 0) ? printf("even") : printf("odd");
}

