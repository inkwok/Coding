#include "gen.h"

const uint8_t WEIGHTS[] = { 40, 65, 80, 90, 97 };

symbol_t
get_symbol(uint8_t v) {
    if(v <= WEIGHTS[0]) return SYM_0;
    if(v <= WEIGHTS[1]) return SYM_1;
    if(v <= WEIGHTS[2]) return SYM_2;
    if(v <= WEIGHTS[3]) return SYM_3;
    if(v <= WEIGHTS[4]) return SYM_4;
    return SYM_5;
}

int
get_weights(board_t* b) {
    uint64_t entropy;
    int i = 0;
    int window = 0;

    if(getrandom(&entropy, sizeof(entropy), 0) != sizeof(entropy)) return 1;
    while(i < LEN_SLOTS) {
        uint8_t slice;

        if(window < 64) slice = (entropy >> window) & 0x7f;
        window += 7;
        if(window >= 64) {
            if(getrandom(&entropy, sizeof(entropy), 0) != sizeof(entropy))
                return 1;
            window = 0;
        }
        if(slice <= 99) b->weights[i++] = slice;
    }
    return 0;
}

board_t
generate_board(void) {
    board_t b = {{0}, {0}, {0}};
    while(get_weights(&b));
    for(int i = 0; i < LEN_SLOTS; i++)
        b.ids[i] = get_symbol(b.weights[i]);
    for(uint8_t i = 0; i < LEN_SLOTS; i++)
        b.bitmaps[b.ids[i]] |= 1 << i;
    return b;
}
