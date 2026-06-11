// #include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <sys/random.h>
// #include <string.h>
#include "gen.h"
// #include "win.h"

// 00 01 02 03 04
// 05 06 07 08 09
// 10 11 12 13 14
// 15 16 17 18 19
// 20 21 22 23 24

#define R5  0x0000001fU
#define R4A 0x0000000fU
#define R4B 0x0000001eU
#define R3A 0x00000007U
#define R3B 0x0000000eU
#define R3C 0x0000001cU

#define C5  0x00108421U
#define C4A 0x00008421U
#define C4B 0x00108420U
#define C3A 0x00000421U
#define C3B 0x00008420U
#define C3C 0x00108400U

const char* const emojis[] = { "🍉", "🍒", "🍋", "🔔", "💰", "💎" };

enum {
    FIVE_IN_A_ROW,
    FOUR_IN_A_ROW,
    THREE_IN_A_ROW,
};

typedef struct {
    uint8_t location;
    uint8_t type;
} payline_t;

typedef struct {
    uint32_t sanitized[NUM_SYMBOLS];
    payline_t paylines[10];
    uint32_t size;
} win_t;

void
print_bitmaps(uint32_t* map) {
    for(int i = 0; i < NUM_SYMBOLS; i++) {
        printf("[%s]:\n", emojis[i]);
        for(int j = 0; j < LEN_SLOTS; j++) {
            putchar((map[i] & (1u << j) ? 'X' : '.'));
            if(j % 5 == 4) putchar('\n');
        }
    }
}

void
print_symbols(board_t b) {
    for(int i = 0; i < LEN_SLOTS; i+= 5) {
        printf("%s %s %s %s %s\n",
        emojis[b.ids[i + 0]], emojis[b.ids[i + 1]],
        emojis[b.ids[i + 2]], emojis[b.ids[i + 3]],
        emojis[b.ids[i + 4]]);
    }
}

void
init_money(uint64_t* money) {

}

void
sanitize_fours(board_t b, win_t* w) {
    for(int i = 0; i < NUM_SYMBOLS; i++) {
        for(int row = 0; row < 5; row++) {
            uint32_t mask = R4A << (row * 5);
            if(((b.bitmaps[i] & mask) == mask) && !(mask & w->sanitized[i])) {
                w->paylines[w->size].location = (row * 5);
                w->paylines[w->size].type = FOUR_IN_A_ROW;
                w->sanitized[i] |= mask;
                w->size++;
            }
        }
        for(int row = 0; row < 5; row++) {
            uint32_t mask = R4B << (row * 5);
            if(((b.bitmaps[i] & mask) == mask) && !(mask & w->sanitized[i])) {
                w->paylines[w->size].location = (row * 5) + 1;
                w->paylines[w->size].type = FOUR_IN_A_ROW;
                w->sanitized[i] |= mask;
                w->size++;
            }
        }

        for(int col = 0; col < 5; col++) {
            uint32_t mask = C4A << col;
            if(((b.bitmaps[i] & mask) == mask) && !(mask & w->sanitized[i])) {
                w->paylines[w->size].location = col;
                w->paylines[w->size].type = FOUR_IN_A_ROW;
                w->sanitized[i] |= mask;
                w->size++;
            }
        }
        for(int col = 0; col < 5; col++) {
            uint32_t mask = C4B << col;
            if(((b.bitmaps[i] & mask) == mask) && !(mask & w->sanitized[i])) {
                w->paylines[w->size].location = col + 5;
                w->paylines[w->size].type = FOUR_IN_A_ROW;
                w->sanitized[i] |= mask;
                w->size++;
            }
        }
    }
}

void
sanitize_fives(board_t* b, win_t* w) {
    for(int i = 0; i < NUM_SYMBOLS; i++) {
        for(int row = 0; row < 5; row++) {
            uint32_t mask = R5 << (row * 5);
            if(((b->bitmaps[i] & mask) == mask) && !(mask & w->sanitized[i])) {
                w->paylines[w->size].location = row * 5;
                w->paylines[w->size].type = FIVE_IN_A_ROW;
                w->sanitized[i] |= mask;
                w->size++;
            }
        }
        for(int col = 0; col < 5; col++) {
            uint32_t mask = C5 << col;
            if(((b->bitmaps[i] & mask) == mask) && !(mask & w->sanitized[i])) {
                w->paylines[w->size].location = col;
                w->paylines[w->size].type = FIVE_IN_A_ROW;
                w->sanitized[i] |= mask;
                w->size++;
            }
        }
    }
    for(int i = 0; i < NUM_SYMBOLS; i++) {
        printf("[%s]:\n", emojis[i]);
        for(int j = 0; j < LEN_SLOTS; j++) {
            putchar((w->sanitized[i] & (1u << j) ? 'X' : '.'));
            if(j % 5 == 4) putchar('\n');
        }
    }

}

// 00 01 02 03 04
// 05 06 07 08 09
// 10 11 12 13 14
// 15 16 17 18 19
// 20 21 22 23 24
win_t
eval_win(board_t b) {
    // check for descending paylines and append to a list.
    // resolve collisions by giving priority to higher-payouts.
    win_t w = {0};

    sanitize_fives(&b, &w);
    return w;
}

int
main(void) {
    board_t b = generate_board();
    print_symbols(b);
    win_t w = eval_win(b);

    print_bitmaps(b.bitmaps);
}
