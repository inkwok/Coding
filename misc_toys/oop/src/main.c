#include <stdio.h>
#include <stdlib.h>

struct stack stack;

struct stack {
    size_t size, capacity;
    int* data;
    int (*push)(struct stack*, int);
    int (*pop)(struct stack*, int);
    int (*peek)(struct stack*, int);
};

int
stack_push(struct stack* s, int val) {
    s->data[s->size++] = val;
    return 1;
}
int
stack_pop(struct stack* s, int* val) {
    if(!s->size) return 0;
    *val = s->data[--s->size];
    return 1;
}

int
stack_peek(struct stack* s, int* val) {
    if(!s->size) return 0;
    *val = s->data[s->size -1];
    return 1;
}

int
main(void) {


}
