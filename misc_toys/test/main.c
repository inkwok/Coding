#include <stdio.h>


int
main(void) {
    int a, b;

    printf("Enter value a: ");
    scanf("%d", &a);
    printf("You entered %d.\n", a);

    printf("Enter value b: ");
    scanf(" %d", &b);
    printf("You entered %d.\n", b);

    int sum = a + b;
    printf("a + b = %d\n", sum);

    return 0;
}
