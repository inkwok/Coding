#ifndef GEN_H
#define GEN_H

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <sys/random.h>
#include <string.h>

#define NUM_SYMBOLS 6
#define LEN_SLOTS 25

typedef enum {
    SYM_0,
    SYM_1,
    SYM_2,
    SYM_3,
    SYM_4,
    SYM_5,
} symbol_t;

typedef struct {
    uint8_t  weights[LEN_SLOTS]; // probabilities
    uint8_t  ids[LEN_SLOTS]; // emoji index
    uint32_t bitmaps[NUM_SYMBOLS]; // win detection uses this
} board_t;

// symbol_t get_symbol(uint8_t v);
// int get_weights(board_t*);

/**
 * Returns a struct of probabilities, symbols, and bitmaps.
 */
board_t generate_board(void);

#endif // GEN_H
