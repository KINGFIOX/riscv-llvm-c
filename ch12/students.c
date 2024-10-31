#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct date {
    int year;
    int month;
    int day;
} DATE;

typedef struct student {
    long studentID;
    char studentName[10];
    char studentSex;
    DATE birthday;
    int score[4];
} STUDENT;

STUDENT changeSex(STUDENT stu, int n, int m)
{
    STUDENT newStu = stu;
    newStu.studentSex = 10;
    return newStu;
}