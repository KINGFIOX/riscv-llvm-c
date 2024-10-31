#include <stdbool.h>
#include <stdio.h>

int main(void)
{
    bool flag;
    unsigned int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    if (a + b > c && b + c > a && a + c > b) {
        flag = true;
        if (a == b && b == c && c == a) {
            printf("等边");
            flag = false;
        } else if (a == b || b == c || c == a) {
            printf("等腰");
            flag = false;
        }
        if (a * a + b * b == c * c || a * a + c * c == b * b || b * b + c * c == a * a) {
            printf("直角");
            flag = false;
        }

        if (flag) {
            printf("一般");
        }
        printf("三角形\n");
    } else {
        printf("不是三角形\n");
    }
}