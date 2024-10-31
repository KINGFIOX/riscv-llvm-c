#include <stdio.h>

int main(int argc, char* argv[])
{
    printf("the number of command line arguments is:%d\n", argc);
    printf("the program name is: %s\n", argv[0]);
    if (argc > 1) {
        printf("the other arguments are following:\n");
        for (size_t i = 1; i < argc; i++) {
            printf("%s\n", argv[i]);
        }
    }
    return 0;
}