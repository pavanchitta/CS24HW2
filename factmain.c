#include <stdio.h>
#include <stdlib.h>


extern int fact(int num);

int main (int argc, char **argv) {

    if (argc != 2) {
        fprintf(stderr, "usage: %s <int>\n", argv[0]);
        exit(1);
    }
    int a = atoi(argv[1]);

    if (a < 0) {
        fprintf(stderr, "Input must be non-negative\n");
        exit(1);
    }
    printf("Result: %d\n", fact(a));

}
