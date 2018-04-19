#include <stdio.h>
#include <stdlib.h>
#include "gcd.h"


int main (int argc, char **argv) {

    if (argc != 3) {
        fprintf(stderr, "usage: %s <int> <int>\n", argv[0]);
        return 1;
    }
    // Convert inputs to ints.
    int a = atoi(argv[1]);
    int b = atoi(argv[2]);

    // Check if inputs are non-negative.
    if (a <= 0 || b <= 0) {
        fprintf(stderr, "Input must be non-negative\n");
        return 2;
    }
    // Since gcd needs a >= b, swap if a < b.
    if (a < b) {
        int temp = b;
        b = a;
        a = temp;
    }
    printf("Result: %d\n", gcd(a, b));

}
