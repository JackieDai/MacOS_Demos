// math_operations.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int add(int a, int b) {
    return a + b;
}

int mod(int a, int b) {
    return a % b;
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        printf("Usage: %s <operation> <num1> <num2>\n", argv[0]);
        return 1;
    }

    char *operation = argv[1];
    int num1 = atoi(argv[2]);
    int num2 = atoi(argv[3]);

    if (strcmp(operation, "add") == 0) {
        printf("%d\n", add(num1, num2));
    } else if (strcmp(operation, "mod") == 0) {
        printf("%d\n", mod(num1, num2));
    } else {
        printf("Unknown operation: %s\n", operation);
        return 1;
    }

    return 0;
}