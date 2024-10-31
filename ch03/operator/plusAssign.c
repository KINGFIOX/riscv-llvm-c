#include <stdio.h>

int main() {
  int a = 21;
  int c;

  c = a;
  printf("Line 1 - =  运算符实例，c 的值 = %d\n", c);
  c += a;
  printf("Line 2 - += 运算符实例，c 的值 = %d\n", c);
}
