#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

/**
 * @brief
 *
 * @param arr
 * @param n
 */
void genRandArr(int arr[], size_t n)
{
    for (size_t i = 0; i < n; i++) {
        arr[i] = random() % 100;
    }
}

void printArr(int arr[], size_t n)
{
    putchar('[');
    for (size_t i = 0; i < n - 1; i++) {
        printf("%d, ", arr[i]);
    }
    printf("%d]\n", arr[n - 1]);
}

void swap(int arr[], size_t i, size_t j)
{
    int tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
}

void sort(int arr[], size_t n)
{
    for (size_t i = 0; i < n; i++) {
        int min = INT_MAX;
        size_t min_index = i;
        for (size_t j = i; j < n; j++) {
            if (min > arr[j]) {
                min = arr[j];
                min_index = j;
            }
        }
        swap(arr, i, min_index);
        printArr(arr, n);
    }
}

int main(void)
{
    size_t n = 10;
    int arr[10];
    genRandArr(arr, n);
    printArr(arr, n);
    sort(arr, n);
    printArr(arr, n);
}