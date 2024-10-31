#include <math.h>
#include <stdio.h>

int main(void)
{
    float a, b, c;
    printf("input a, b, c: ");
    scanf("%f, %f, %f", &a, &b, &c);
    float s = (float)(a + b + c) / 2;
    float area = sqrt(s * (s - a) * (s - b) * (s - c));
    printf("area = %f\n", area);
}