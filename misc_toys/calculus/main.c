#include <stdio.h>

typedef struct expression {
    int* coefficient;
    int size;
} Expression;

char*
get_function(Expression x) {
    int scanf_return = 1;
    while(scanf_return != EOF) {
        scanf_return = scanf("%99");
    }
}

int
main(void) {
    Expression x;

    return 0;
}
