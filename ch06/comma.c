#include <stdio.h>

int main(void) {
  int sum = 0, n = 100;
  for (int i = 1, j = n; i <= j; i++, j--) {
    sum = sum + i + j;
  }
  printf("sum = %d\n", sum);

  // 来点 傻逼题目
  int a = 10;
  volatile int b;
  b = 3 * 5, a * 4;
  printf("b = %d\n", b); // 15

  // comma 表达式运算等级最低
  b = (3 * 5, a * 4);
  printf("b = %d\n", b); // 40
}

// 这个文件，看看 comma 在 asm 上是如何解释的，以及这个
// 如果是多个循环条件，该如何解释
