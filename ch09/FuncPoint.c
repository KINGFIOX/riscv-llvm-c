#include <stdio.h>

#include <stdbool.h>
#include <stdio.h>

// 二元谓词函数原型，用于比较两个整数
bool ascending(int a, int b) { return a > b; }

bool descending(int a, int b) { return a < b; }

// 通用排序函数，使用函数指针作为二元谓词
void sort(int* array, int size, bool (*compare)(int, int))
{
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (compare(array[j], array[j + 1])) {
                // 交换元素
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

// 打印数组
void printArray(int* array, int size)
{
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    putchar('\n');
}

int main()
{
    int array[] = { 5, 2, 9, 1, 5, 6 };
    int size = sizeof(array) / sizeof(array[0]);

    printf("Original array: \n");
    printArray(array, size);

    // 使用升序排序
    sort(array, size, ascending);
    printf("Sorted array in ascending order: \n");
    printArray(array, size);

    // 使用降序排序
    sort(array, size, descending);
    printf("Sorted array in descending order: \n");
    printArray(array, size);

    return 0;
}
