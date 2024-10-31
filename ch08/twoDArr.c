#include <stdio.h>

int main(void)
{
    int arr[][3] = { { 1, 2, 3 }, { 4, 5 }, { 6 }, { 0 } };
    /**
     * 1, 2, 3
     * 4, 5, 0
     * 6, 0, 0
     * 0, 0, 0
     */
    printf("%d\n", arr[1][1]);
    return 0;
}