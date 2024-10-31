#include <stdio.h>

#define N 40

float Average(int score[], int n)
{
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += score[i];
    }

    return (float)sum / n;
}

void ReadScore(int score[], int n)
{
    printf("input socre: ");
    for (int i = 0; i < n; i++) {
        scanf("%d", &score[i]);
    }
}

int main(void)
{
    printf("input n:");
    int n;
    scanf("%d", &n);

    int score[N];
    ReadScore(score, n);

    float aver = Average(score, n);

    printf("Average score is %f\n", aver);

    return 0;
}