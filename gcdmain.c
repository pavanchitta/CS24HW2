#include <stdio.h>
#include <stdlib.h>
#include "gcd.h"



int main (int argc, char **argv)
{
    if (argc != 3)
    {
        printf("usage: gcdmain <int> <int>");
        exit(1);
    }
    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    if (a <= 0 || b <= 0)
    {
        printf("input must be non-negative");
        exit(1);
    }
    printf("Result: %d \n", gcd(a, b));

}
