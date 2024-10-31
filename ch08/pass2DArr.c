#include <stdio.h>
#define COURSE_N 5

void AverforStud(int score[][COURSE_N], int sum[], float aver[], size_t n) {
  for (size_t i = 0; i < n; i++) {
    for (size_t j = 0; i < COURSE_N; i++) {
      sum[i] = sum[i] + score[i][j];
    }
    aver[i] = (float)sum[i] / COURSE_N;
  }
}
