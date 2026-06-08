#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/random.h>
#include <stdbool.h>
#include <string.h>

#define NUM_SYMBOLS 6
#define LEN_SLOTS 25

const char* const emojis[] = { "🍉", "🍒", "🍋", "🔔", "💰", "💎" };
const uint8_t WEIGHTS[] = { 40, 65, 80, 90, 97 };

typedef enum {
    SYM_0,
    SYM_1,
    SYM_2,
    SYM_3,
    SYM_4,
    SYM_5,
} symbol_t;

typedef uint32_t payline_t;

typedef struct {
    uint8_t  weights[LEN_SLOTS]; // probabilities
    uint8_t  ids[LEN_SLOTS]; // emoji index
    uint32_t bitmaps[NUM_SYMBOLS]; // win detection uses this
    bool win;

} board_t;

void
print_bitmaps(board_t b) {
    for(int j = 0; j < NUM_SYMBOLS; j++) {
        printf("[%s]:\n", emojis[j]);
        for(int i = 0; i < LEN_SLOTS; i++) {
            putchar((b.bitmaps[j] & (1u << i) ? 'X' : '.'));
            if(i % 5 == 4) putchar('\n');
        }
    }
}

void
print_symbols(uint8_t* slot_id) {
    for(int i = 0; i < LEN_SLOTS; i += 5) {
        printf("%s %s %s %s %s\n",
            emojis[slot_id[i + 0]], emojis[slot_id[i + 1]],
            emojis[slot_id[i + 2]], emojis[slot_id[i + 3]],
            emojis[slot_id[i + 4]]);
    }
}

void
get_bitmaps(board_t* b) {
    memset(b->bitmaps, 0, sizeof(b->bitmaps));
    // for(uint8_t i = 0; i < NUM_SYMBOLS; i++) b->bitmaps[i] = 0;
    for(uint8_t i = 0; i < LEN_SLOTS; i++)
        b->bitmaps[b->ids[i]] |= 1 << i;
}

symbol_t
get_symbol(uint8_t v) {
    if(v <= WEIGHTS[0]) return SYM_0;
    if(v <= WEIGHTS[1]) return SYM_1;
    if(v <= WEIGHTS[2]) return SYM_2;
    if(v <= WEIGHTS[3]) return SYM_3;
    if(v <= WEIGHTS[4]) return SYM_4;
    return SYM_5;
}

void
get_ids(board_t* b) {
    for(int i = 0; i < LEN_SLOTS; i++) b->ids[i] = get_symbol(b->weights[i]);
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

void
init_money(uint64_t* money) {

}

board_t
generate_board() {
    board_t b;
    int retval = 1;
    while(get_weights(&b));
    get_ids(&b);
    get_bitmaps(&b);
    return b;
}

int
eval_win(board_t b) {
    // check for descending paylines and append to a list.
    // resolve collisions by giving priority to higher-payouts.
    return 0;
}

int
main(void) {
    board_t b = generate_board();
    eval_win(b);
}
