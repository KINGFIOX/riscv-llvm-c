#include <stdio.h>

int main(void)
{
    int data1, data2;
    char op;
    printf("please enter the expression: ");
    scanf("%d%c%d", &data1, &op, &data2);

    switch (op) {
    case '+':
        printf("%d + %d = %d\n", data1, data2, data1 + data2);
        break;
    case '-':
        printf("%d - %d = %d\n", data1, data2, data1 - data2);
        break;
    case '*':
        printf("%d * %d = %d\n", data1, data2, data1 - data2);
        break;
    case '/':
        // 这里是 0 == data2 ，是为了防止 自己不小心写成了 data2 = 0 ；因为我们知道 右值是不能被赋值的
        if (0 == data2) {
            perror("division by zero!\n");
        } else {
            printf("%d / %d = %d\n", data1, data2, data1 / data2);
        }
        break;
    default:
        perror("division by zero!\n");
    }

    return 0;
}