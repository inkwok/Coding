#include <stdio.h>
#include <stdint.h>
#include <sys/random.h> //getrandom may return -1 on failure
#include <stdbool.h>
// generate 25 symbols
#define NUM_SYMBOLS 6

enum {
    SYM_0,
    SYM_1,
    SYM_2,
    SYM_3,
    SYM_4,
    SYM_5,
};

static inline int generate_table(uint8_t* symbol_table) {
    uint64_t x[2];
    if(getrandom(x, sizeof(x), 0) != 16) return 1;
    uint64_t pool1 = x[0];
    uint64_t pool2 = x[1];

    int i = 0;
    int window = 0;

    while(i < 25) {
        uint8_t octal;
        if(window < 64)
            octal = (pool1 >> window) & 7;
        else
            octal = (pool2 >> (window - 64)) & 7;
        window += 3;

        if(window >= 124) {
            if(getrandom(x, sizeof(x), 0) != 16) return 1;
            pool1 = x[0];
            pool2 = x[1];
            window = 0;
        }

        if(octal < NUM_SYMBOLS)
            symbol_table[i++] = octal + 1;
    }
    
    
    return 0;
}

int main(void) {
    uint8_t symbols[25] = {0};
    if(generate_table(symbols)) return 1;

    for(int i = 0; i < 25; i++) {
        printf("%u\n", symbols[i]);
    }

    return 0;
}
