#include <stdio.h>

int main() {
  int a = 21;
  int b = 10;
  int c;

  c = a + b;
  printf("Line 1 - c 的值是 %d\n", c);
  c = a - b;
  printf("Line 2 - c 的值是 %d\n", c);
  c = a * b;
  printf("Line 3 - c 的值是 %d\n", c);
  c = a / b;
  printf("Line 4 - c 的值是 %d\n", c);
  c = a % b;
  printf("Line 5 - c 的值是 %d\n", c);
  c = a++; // 赋值后再加 1 ，c 为 21，a 为 22
  printf("Line 6 - c 的值是 %d\n", c);
  c = a--; // 赋值后再减 1 ，c 为 22 ，a 为 21
  printf("Line 7 - c 的值是 %d\n", c);

  // 当然啦，riscv 汇编中，其实是可以直接位运算的啦
  
  /*
   * xor a5,a4,a5
   * or a5,a4,a5
   * and a5,a4,a5
   */
}
